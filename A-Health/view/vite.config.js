import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
    },
  },
  server: {
    host: 'localhost',
    port: 21091,
    proxy: {
      '/api': {
        target: 'http://localhost:21090',
        changeOrigin: true,
      },
    },
  },
})
