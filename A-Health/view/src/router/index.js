import { createRouter, createWebHistory } from 'vue-router'
import { clearToken, getToken, getRole } from "@/utils/storage.js";

const routes = [
  {
    path: "/",
    redirect: '/login'
  },
  {
    path: "/login",
    name: 'login',
    component: () => import('@/views/login/Login.vue')
  },
  {
    path: "/recipe-detail",
    name: 'recipeDetail',
    component: () => import('@/views/user/RecipeDetail.vue')
  },
  {
    path: "/health-news-detail",
    name: 'healthNewsDetail',
    component: () => import('@/views/user/HealthNewsDetail.vue')
  },
  {
    path: "/health-record",
    name: 'healthRecord',
    component: () => import('@/views/user/HealthRecord.vue')
  },
  {
    path: "/my-diet",
    name: 'MyDiet',
    component: () => import('@/views/user/MyDiet.vue')
  },
  {
    path: "/register",
    name: 'register',
    component: () => import('@/views/register/Register.vue')
  },
  {
    path: "/admin",
    component: () => import('@/views/admin/Home.vue'),
    meta: { requireAuth: true },
    children: [
      {
        path: "layout",
        name: '仪表盘',
        icon: 'PieChart',
        show: true,
        component: () => import('@/views/admin/Main.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "user-manage",
        name: '用户管理',
        show: true,
        icon: 'User',
        component: () => import('@/views/admin/UserManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "health-news-manage",
        name: '健康资讯管理',
        show: true,
        icon: 'Tickets',
        component: () => import('@/views/admin/HealthNewsManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "health-model-manage",
        name: '健康模型管理',
        show: true,
        icon: 'Box',
        component: () => import('@/views/admin/HealthModelManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "health-record-manage",
        name: '健康记录管理',
        show: true,
        icon: 'ScaleToOriginal',
        component: () => import('@/views/admin/HealthRecordManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "evaluations-manage",
        name: '评论管理',
        show: true,
        icon: 'ChatDotRound',
        component: () => import('@/views/admin/EvaluationsManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "recipe-manage",
        name: '食谱管理',
        show: true,
        icon: 'Tickets',
        component: () => import('@/views/admin/RecipeManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "diet-history-manage",
        name: '饮食记录',
        show: true,
        icon: 'ShoppingCartFull',
        component: () => import('@/views/admin/DietHistoryManage.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "update-password",
        name: '修改个人密码',
        show: false,
        component: () => import('@/views/admin/UpdatePassword.vue'),
        meta: { requireAuth: true },
      },
    ]
  },
  {
    path: "/user",
    component: () => import('@/views/user/Main.vue'),
    meta: { requireAuth: true },
    children: [
      {
        path: "home",
        name: '首页',
        component: () => import('@/views/user/Home.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "recipe-list",
        name: '食谱列表',
        component: () => import('@/views/user/RecipeList.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "health-data",
        name: '健康数据',
        component: () => import('@/views/user/HealthData.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "collection-folder",
        name: '收藏夹',
        component: () => import('@/views/user/CollectionFolder.vue'),
        meta: { requireAuth: true },
      },
      {
        path: "ai-chat",
        name: '智能健康助手',
        component: () => import('@/views/user/AIChat.vue'),
        meta: { requireAuth: true },
      },
    ]
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  if (to.path === '/login' || to.path === '/register') {
    return next();
  }

  if (to.matched.some(record => record.meta.requireAuth)) {
    const token = getToken();

    if (!token) {
      return next({
        path: '/login',
        query: { redirect: to.fullPath }
      });
    }

    try {
      const role = parseInt(getRole() || '0');

      if (to.matched[0].path === '/admin' && role !== 1) {
        clearToken();
        return next("/login");
      }

      if (to.matched[0].path === '/user' && role !== 2 && role !== 1) {
        clearToken();
        return next("/login");
      }

      return next();
    } catch (error) {
      console.error('权限检查失败:', error);
      return next('/login');
    }
  }

  next();
});

export default router;
