import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
import './assets/css/style.scss';
import './assets/css/code-highlight.scss';
import './assets/css/wang-editor.scss';
import './assets/css/elementui-cover.scss';
import request from '@/utils/request';
import md5 from 'js-md5';
import { ElMessage, ElMessageBox, ElNotification } from 'element-plus';

const app = createApp(App);
app.use(router);
app.use(ElementPlus);

// Register all Element Plus icons globally
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}

// Vue 2 compatibility: global properties
app.config.globalProperties.$md5 = md5;
app.config.globalProperties.$axios = request;
app.config.globalProperties.$message = ElMessage;
app.config.globalProperties.$confirm = ElMessageBox.confirm;
app.config.globalProperties.$notify = ElNotification;

app.mount("#app");
