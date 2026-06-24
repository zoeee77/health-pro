import axios from 'axios'
import { getToken, clearToken } from '@/utils/storage'
import { ElMessage } from 'element-plus'

const ENV = import.meta.env.MODE
const BASE_URL_MAP = {
  development: 'http://localhost:21090/api/v1.0/self-health-api',
  test: 'http://test-api.example.com/api',
  production: 'https://api.example.com/v1'
}

const request = axios.create({
  baseURL: BASE_URL_MAP[ENV] || BASE_URL_MAP.development,
  timeout: 60000,
  headers: {
    'Content-Type': 'application/json;charset=UTF-8'
  }
})

const pendingRequests = new Map()

const generateReqKey = (config) => {
  const { method, url, params, data } = config
  return [method, url, JSON.stringify(params), JSON.stringify(data)].join('&')
}

const addPendingRequest = (config) => {
  const requestKey = generateReqKey(config)
  config.cancelToken = config.cancelToken || new axios.CancelToken(cancel => {
    if (!pendingRequests.has(requestKey)) {
      pendingRequests.set(requestKey, cancel)
    }
  })
}

const removePendingRequest = (config) => {
  const requestKey = generateReqKey(config)
  if (pendingRequests.has(requestKey)) {
    const cancel = pendingRequests.get(requestKey)
    cancel(requestKey)
    pendingRequests.delete(requestKey)
  }
}

const clearPendingRequests = () => {
  for (const [requestKey, cancel] of pendingRequests) {
    cancel(requestKey)
  }
  pendingRequests.clear()
}

request.interceptors.request.use(
  config => {
    removePendingRequest(config)
    addPendingRequest(config)

    const token = getToken()
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }

    if (config.method === 'get' && config.params) {
      config.paramsSerializer = params => {
        return Object.keys(params)
          .map(key => {
            if (Array.isArray(params[key])) {
              return params[key].map(item => `${key}=${item}`).join('&')
            }
            return `${key}=${params[key]}`
          })
          .join('&')
      }
    }

    return config
  },
  error => {
    return Promise.reject(error)
  }
)

request.interceptors.response.use(
  response => {
    removePendingRequest(response.config)

    const { data, status } = response
    const { code, message } = data

    if (code !== undefined && code !== 200) {
      if (code === 401) {
        clearToken()
        return Promise.reject(new Error('登录状态已过期，请重新登录'))
      }
      return Promise.reject(data)
    }

    return data
  },
  error => {
    if (error.config) {
      removePendingRequest(error.config)
    }

    if (error.code === 'ECONNABORTED' && error.message.includes('timeout')) {
      ElMessage.error('请求超时，请重试')
      return Promise.reject(error)
    }

    if (axios.isCancel(error)) {
      console.log(error)
      return Promise.reject()
    }

    const { response } = error
    if (response) {
      switch (response.status) {
        case 400:
          error.message = '请求参数错误'
          break
        case 401:
          clearToken()
          break
        case 403:
          error.message = '拒绝访问'
          break
        case 404:
          error.message = `请求地址不存在: ${error.config.url}`
          break
        case 500:
          error.message = '服务器内部错误'
          break
        case 503:
          error.message = '服务不可用'
          break
        default:
          error.message = `连接错误 ${response.status}`
      }
    } else {
      error.message = '网络连接异常'
    }
    return Promise.reject(error)
  }
)

export const get = (url, params = {}, config = {}) => {
  return request({ method: 'get', url, params, ...config })
}

export const post = (url, data = {}, config = {}) => {
  return request({ method: 'post', url, data, ...config })
}

export const put = (url, data = {}, config = {}) => {
  return request({ method: 'put', url, data, ...config })
}

export const del = (url, params = {}, config = {}) => {
  return request({ method: 'delete', url, params, ...config })
}

export const upload = (url, file, config = {}) => {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    method: 'post',
    url,
    data: formData,
    headers: { 'Content-Type': 'multipart/form-data' },
    ...config
  })
}

export default request
export { clearPendingRequests }
