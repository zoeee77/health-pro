<template>
  <div class="chat-layout">
    <!-- 侧边栏 -->
    <div class="sidebar" :class="{ 'sidebar-collapsed': !sidebarVisible }">
      <div class="sidebar-header">
        <span class="sidebar-title">对话</span>
        <el-button class="sidebar-toggle" @click="sidebarVisible = false" link>
          <i class="el-icon-s-fold"></i>
        </el-button>
      </div>
      <el-button class="new-chat-btn" type="primary" @click="createNewSession" plain round>
        <i class="el-icon-plus"></i> 新对话
      </el-button>
      <div class="session-list" v-loading="sessionLoading">
        <div
          v-for="session in sessions"
          :key="session.id"
          :class="['session-item', { active: sessionId === session.id }]"
          @click="switchSession(session.id)"
        >
          <i class="el-icon-chat-line-round session-icon"></i>
          <span class="session-title" :title="session.title">{{ session.title }}</span>
          <div
            class="session-delete"
            @click.stop="confirmDeleteSession(session.id, session.title)"
          >✕</div>
        </div>
        <div v-if="sessions.length === 0 && !sessionLoading" class="empty-session">
          暂无对话记录
        </div>
      </div>
    </div>

    <!-- 聊天主区域 -->
    <div class="chat-main">
      <div class="ai-chat-container">
        <div class="chat-header">
          <el-button class="menu-btn" @click="sidebarVisible = true" link>
            <i class="el-icon-s-unfold"></i>
          </el-button>
          <h2>智能健康助手</h2>
          <p>专注于健康领域的AI助手，为您提供个性化的健康建议</p>
          <div v-if="apiStatus" class="api-status" :class="apiStatus.available ? 'status-available' : 'status-unavailable'">
            <i class="el-icon-warning-outline" v-if="!apiStatus.available"></i>
            <i class="el-icon-check" v-else></i>
            {{ apiStatus.message }}
          </div>
        </div>
        
        <div class="chat-messages" ref="chatMessages">
          <div 
            v-for="(message, index) in messages" 
            :key="index"
            :class="['message-wrapper', message.role === 'user' ? 'user-message-wrapper' : 'ai-message-wrapper']"
          >
            <div class="message-avatar ai-avatar" v-if="message.role === 'ai'">
              <i class="el-icon-s-custom"></i>
            </div>
            <div class="message-avatar user-avatar" v-if="message.role === 'user'">
              <img v-if="userInfo.avatar" :src="userInfo.avatar" alt="用户头像" class="avatar-image">
              <i v-else class="el-icon-user"></i>
            </div>
            <div 
              :class="['message', message.role === 'user' ? 'user-message' : 'ai-message']"
            >
              <div v-if="message.isTyping" class="loading-indicator">
                <div class="loading-dot"></div>
                <div class="loading-dot"></div>
                <div class="loading-dot"></div>
              </div>
              <div v-else class="message-content" v-html="formatMessage(message.content, message.role)">
              </div>
              <div class="message-time">
                {{ message.time }}
              </div>
            </div>
            
          </div>
        </div>
        
        <div class="chat-input">
          <el-input
            v-model="inputMessage"
            type="textarea"
            :rows="2"
            placeholder="请输入您的健康问题..."
            @keydown.enter.exact.prevent="sendMessage"
            @keydown.enter.shift.exact="handleShiftEnter"
          />
          <el-button type="primary" @click="sendMessage" :loading="isLoading" :disabled="!apiStatus.available">
            {{ isLoading ? '发送中...' : '发送' }}
          </el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AIChat',
  data() {
    return {
      sidebarVisible: true,
      sessions: [],
      sessionLoading: false,
      messages: [],
      inputMessage: '',
      isLoading: false,
      apiStatus: {
        available: true,
        message: 'API连接正常'
      },
      userInfo: {},
      sessionId: null,
      welcomeMessage: {
        role: 'ai',
        content: '您好！我是您的智能健康助手。请问有什么健康问题需要咨询？',
        time: new Date().toLocaleTimeString()
      }
    };
  },
  mounted() {
    this.checkApiAvailability();
    this.getUserInfo();
    this.initSession();
  },
  methods: {
    getUserInfo() {
      const userInfo = localStorage.getItem('userInfo');
      if (userInfo) {
        try {
          this.userInfo = JSON.parse(userInfo);
        } catch (e) {
          console.error('解析用户信息失败:', e);
          this.userInfo = {};
        }
      } else {
        this.$axios.get('/user/info')
          .then(response => {
            if (response.code === 200) {
              this.userInfo = response.data;
              localStorage.setItem('userInfo', JSON.stringify(response.data));
            }
          })
          .catch(error => {
            console.error('获取用户信息失败:', error);
          });
      }
    },
    checkApiAvailability() {
      this.$axios.get('/ai-chat/check-availability')
        .then(response => {
          if (response.code === 200) {
            this.apiStatus = {
              available: true,
              message: 'API连接正常'
            };
          } else {
            this.apiStatus = {
              available: false,
              message: response.message || 'API连接异常'
            };
          }
        })
        .catch(error => {
          console.error('检测API可用性失败:', error);
          this.apiStatus = {
            available: false,
            message: 'API连接失败，请联系管理员'
          };
        });
    },
    initSession() {
      this.loadSessions();
    },
    loadSessions() {
      this.sessionLoading = true;
      this.$axios.get('/ai-chat/session/list')
        .then(response => {
          this.sessions = response.data || [];
          this.sessionLoading = false;
          if (this.sessions.length > 0) {
            this.sessionId = this.sessions[0].id;
            this.loadSessionMessages();
          } else {
            this.createNewSession();
          }
        })
        .catch(() => {
          this.sessionLoading = false;
          this.createNewSession();
        });
    },
    createNewSession() {
      this.$axios.post('/ai-chat/session/create', { title: '' })
        .then(response => {
          if (response && response.data) {
            this.sessionId = response.data;
            this.messages = [];
            this.messages.push(this.welcomeMessage);
            // 刷新会话列表
            this.loadSessions();
          }
        })
        .catch(() => {
          this.messages.push(this.welcomeMessage);
        });
    },
    switchSession(sessionId) {
      this.sessionId = sessionId;
      this.loadSessionMessages();
    },
    loadSessionMessages() {
      if (!this.sessionId) return;
      this.$axios.get(`/ai-chat/session/messages/${this.sessionId}`)
        .then(response => {
          if (response && response.data && response.data.length > 0) {
            this.messages = response.data.map(msg => ({
              role: msg.role === 'user' ? 'user' : 'ai',
              content: msg.content,
              time: msg.createTime || new Date().toLocaleTimeString()
            }));
          } else {
            this.messages = [];
            this.messages.push(this.welcomeMessage);
          }
          this.scrollToBottom();
        })
        .catch(() => {
          this.messages = [];
          this.messages.push(this.welcomeMessage);
        });
    },
    confirmDeleteSession(sessionId, title) {
      this.$confirm(`确定要删除「${title}」吗？删除后无法恢复。`, '删除确认', {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.deleteSession(sessionId);
      }).catch(() => {});
    },
    deleteSession(sessionId) {
      this.$axios.delete(`/ai-chat/session/delete/${sessionId}`)
        .then(() => {
          this.$message.success('已删除');
          // 如果删除的是当前会话，切换回第一个
          if (this.sessionId === sessionId) {
            this.sessions = this.sessions.filter(s => s.id !== sessionId);
            if (this.sessions.length > 0) {
              this.sessionId = this.sessions[0].id;
              this.loadSessionMessages();
            } else {
              this.sessionId = null;
              this.messages = [];
              this.createNewSession();
            }
          } else {
            this.loadSessions();
          }
        })
        .catch(() => {
          this.$message.error('删除失败');
        });
    },

    handleShiftEnter(event) {
      if (event.shiftKey && event.key === 'Enter') {
        this.inputMessage += '\n';
      }
    },
    scrollToBottom() {
      this.$nextTick(() => {
        const chatMessages = this.$refs.chatMessages;
        if (chatMessages) {
          chatMessages.scrollTop = chatMessages.scrollHeight;
        }
      });
    },
    formatMessage(content, role) {
      if (!content) return '';
      
      let formattedContent = content;
      formattedContent = formattedContent.replace(/###\s+(.+?)(?=\n|$)/g, '<h3>$1</h3>');
      formattedContent = formattedContent.replace(/##\s+(.+?)(?=\n|$)/g, '<h3>$1</h3>');
      formattedContent = formattedContent.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>');
      formattedContent = formattedContent.replace(/\n/g, '<br>');
      
      return formattedContent;
    },
    sendMessage() {
      if (!this.inputMessage.trim() || this.isLoading || !this.apiStatus.available) return;
      
      const userMessage = {
        role: 'user',
        content: this.inputMessage.trim(),
        time: new Date().toLocaleTimeString()
      };
      this.messages.push(userMessage);
      this.inputMessage = '';
      
      this.scrollToBottom();
      
      const tempMessageId = this.messages.length;
      const tempMessage = {
        role: 'ai',
        content: '',
        time: '',
        isTyping: true
      };
      this.messages.push(tempMessage);
      this.scrollToBottom();
      
      this.isLoading = true;
      const messageContent = this.messages[this.messages.length - 2].content;
      const requestData = { message: messageContent };
      if (this.sessionId) {
        requestData.sessionId = this.sessionId;
      }
      this.$axios.post('/ai-chat/send', requestData)
        .then(response => {
          if (response) {
            let content = '抱歉，我暂时无法回答您的问题，请稍后重试。';
            if (typeof response === 'object') {
              if (response.data) {
                if (typeof response.data === 'string') {
                  let cleanedContent = response.data;
                  if (cleanedContent.startsWith('{') && cleanedContent.includes('code') && cleanedContent.includes('message')) {
                    try {
                      const parsed = JSON.parse(cleanedContent);
                      if (parsed.data) {
                        cleanedContent = typeof parsed.data === 'string' ? parsed.data : JSON.stringify(parsed.data);
                      } else {
                        cleanedContent = '抱歉，我暂时无法回答您的问题，请稍后重试。';
                      }
                    } catch (e) {}
                  }
                  content = cleanedContent;
                } else if (typeof response.data === 'object') {
                  if (response.data.data) {
                    content = typeof response.data.data === 'string' ? response.data.data : (response.data.data.content ? response.data.data.content : JSON.stringify(response.data.data));
                  } else if (response.data.content) {
                    content = typeof response.data.content === 'string' ? response.data.content : JSON.stringify(response.data.content);
                  } else if (response.data.message) {
                    content = typeof response.data.message === 'string' ? response.data.message : JSON.stringify(response.data.message);
                  }
                }
              } else if (response.content) {
                content = typeof response.content === 'string' ? response.content : JSON.stringify(response.content);
              } else if (response.message) {
                content = typeof response.message === 'string' ? response.message : JSON.stringify(response.message);
              }
            }
            this.typewriterEffect(tempMessageId, content);
          } else {
            this.typewriterEffect(tempMessageId, '抱歉，我暂时无法回答您的问题，请稍后重试。');
          }
        })
        .catch(error => {
          console.error('发送消息失败:', error);
          this.typewriterEffect(tempMessageId, '抱歉，网络错误，请稍后重试。');
        })
        .finally(() => {
          this.isLoading = false;
          this.loadSessions();
        });
    },
    typewriterEffect(messageId, content) {
      let index = 0;
      const message = this.messages[messageId];
      message.content = '';
      message.time = new Date().toLocaleTimeString();
      message.isTyping = false;
      
      const typingInterval = setInterval(() => {
        if (index < content.length) {
          message.content = content.substring(0, index + 1);
          index++;
          this.scrollToBottom();
        } else {
          clearInterval(typingInterval);
          this.scrollToBottom();
        }
      }, 30);
    }
  }
};
</script>

<style scoped>
.chat-layout {
  display: flex;
  height: 800px;
  background-color: #f5f5f5;
}

/* 侧边栏 */
.sidebar {
  width: 260px;
  background-color: #f7f7f7;
  border-right: 1px solid #e5e5e5;
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  transition: width 0.3s, transform 0.3s;
}

.sidebar-collapsed {
  width: 0;
  overflow: hidden;
  border: none;
}

.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 12px;
  border-bottom: 1px solid #e5e5e5;
}

.sidebar-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.sidebar-toggle {
  font-size: 18px;
  color: #666;
}

.new-chat-btn {
  margin: 12px;
  font-weight: 500;
}

.session-list {
  flex: 1;
  overflow-y: auto;
  padding: 8px;
}

.session-item {
  display: flex;
  align-items: center;
  padding: 10px 12px;
  border-radius: 8px;
  cursor: pointer;
  margin-bottom: 4px;
  transition: background-color 0.2s;
}

.session-item:hover {
  background-color: #e9ecef;
}

.session-item.active {
  background-color: #d4e8ff;
  color: #0050b3;
}

.session-icon {
  font-size: 16px;
  color: #999;
  margin-right: 8px;
  flex-shrink: 0;
}

.session-title {
  flex: 1;
  font-size: 14px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.session-delete {
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  margin-left: 8px;
  opacity: 0;
  transition: opacity 0.2s, color 0.2s;
  flex-shrink: 0;
  cursor: pointer;
  font-size: 12px;
  border-radius: 50%;
}

.session-item:hover .session-delete {
  opacity: 1;
}

.session-delete:hover {
  color: #ff4d4f;
  background-color: rgba(255,77,79,0.1);
}

.empty-session {
  text-align: center;
  color: #999;
  font-size: 14px;
  padding: 20px 0;
}

/* 聊天主区域 */
.chat-main {
  flex: 1;
  overflow: hidden;
}

.ai-chat-container {
  height: 100%;
  display: flex;
  flex-direction: column;
  margin: 0;
  padding: 0;
  overflow: hidden;
  position: relative;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
}

.chat-header {
  background-color: #f7f7f7;
  color: #333;
  padding: 10px 16px;
  border-bottom: 1px solid #e5e5e5;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 12px;
  flex-shrink: 0;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.chat-header h2 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  white-space: nowrap;
}

.chat-header p {
  margin: 0;
  font-size: 12px;
  color: #999;
  white-space: nowrap;
}

.menu-btn {
  font-size: 20px;
  color: #666;
  display: none;
}

.api-status {
  font-size: 11px;
  padding: 3px 8px;
  border-radius: 10px;
  display: inline-block;
  background-color: #f0f0f0;
  color: #666;
  white-space: nowrap;
  margin-left: auto;
}

.status-available {
  background-color: #e6f7ee;
  color: #52c41a;
}

.status-unavailable {
  background-color: #fff1f0;
  color: #ff4d4f;
}

.chat-messages {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 16px;
  background-color: #f0f2f5;
  background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2MCIgaGVpZ2h0PSI2MCIgdmlld0JveD0iMCAwIDYwIDYwIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik0zNiAzNEg0MlY0MEgzNnYtNnptNi05SDB2MTZoNDJ2LTZoLTM2em0wIDl2MTZoNDJ2LTZoLTR6bS0yN3YxNmgyN3YtMTZ6IiBmaWxsPSIjZmZmZmZmMjAiLz48cGF0aCBkPSJNMTUgMjRoMjh2LTZoLTI4eiIgc3Ryb2tlPSIjZmZmZmZmMzAiIHN0cm9rZS13aWR0aD0iMiIvPjwvZz48L3N2Zz4=');
  background-size: 60px 60px;
}

.message-wrapper {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  max-width: 70%;
}

.ai-message-wrapper {
  align-self: flex-start;
  flex-direction: row;
}

.user-message-wrapper {
  align-self: flex-end;
  flex-direction: row-reverse;
  justify-content: flex-start;
}

.message-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background-color: #eaeaea;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  flex-shrink: 0;
  overflow: hidden;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.ai-avatar {
  background-color: #409EFF;
  color: white;
}

.user-avatar {
  background-color: #67C23A;
  color: white;
}

.avatar-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 50%;
}

.message {
  max-width: 100%;
  padding: 10px 14px;
  border-radius: 18px;
  word-wrap: break-word;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  position: relative;
}

.user-message {
  background-color: #00C200;
  color: white;
  border-bottom-right-radius: 4px;
}

.ai-message {
  background-color: white;
  color: #333;
  border-bottom-left-radius: 4px;
}

.message-content {
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 4px;
}

.message-time {
  font-size: 11px;
  color: #999;
  text-align: right;
  margin-top: 2px;
}

.chat-input {
  padding: 10px 16px;
  background-color: #f7f7f7;
  border-top: 1px solid #e5e5e5;
  display: flex;
  gap: 10px;
  align-items: flex-end;
  flex-shrink: 0;
  box-shadow: 0 -1px 10px rgba(0, 0, 0, 0.05);
}

.chat-input .el-input {
  flex: 1;
  border-radius: 20px;
  overflow: hidden;
  background-color: white;
  border: 1px solid #e5e5e5;
}

.chat-input .el-input__inner {
  border-radius: 20px;
  resize: none;
  min-height: 36px;
  max-height: 100px;
  padding: 8px 16px;
  border: none;
  font-size: 14px;
}

.chat-input .el-button {
  min-width: 60px;
  height: 36px;
  border-radius: 18px;
  font-weight: 500;
  font-size: 14px;
  background-color: #07C160;
  border-color: #07C160;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.chat-input .el-button:hover {
  background-color: #05ae54;
  border-color: #05ae54;
}

.chat-input .el-button:disabled {
  background-color: #c9c9c9;
  border-color: #c9c9c9;
}

/* 滚动条样式 */
.chat-messages::-webkit-scrollbar {
  width: 6px;
}

.chat-messages::-webkit-scrollbar-track {
  background: transparent;
}

.chat-messages::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 3px;
}

.chat-messages::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

.message-enter-active,
.message-leave-active {
  transition: all 0.3s ease;
}

.message-enter-from,
.message-leave-to {
  opacity: 0;
  transform: translateY(10px);
}

.loading-indicator {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 0;
}

.loading-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: #409EFF;
  animation: loading-bounce 1.4s infinite ease-in-out both;
}

.loading-dot:nth-child(1) {
  animation-delay: -0.32s;
}

.loading-dot:nth-child(2) {
  animation-delay: -0.16s;
}

@keyframes loading-bounce {
  0%, 80%, 100% {
    transform: scale(0);
  }
  40% {
    transform: scale(1);
  }
}

/* 响应式 */
@media (max-width: 768px) {
  .sidebar {
    position: absolute;
    z-index: 10;
    height: 100%;
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
  }
  .sidebar-collapsed {
    transform: translateX(-100%);
  }
  .menu-btn {
    display: inline-flex;
  }
}
</style>
