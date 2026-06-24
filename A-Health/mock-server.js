const http = require('http');
const url = require('url');

const PORT = 21090;
const USERS = [
  { id: 1, account: 'admin', password: '123456', username: '管理员', role: 1, avatar: '', email: 'admin@test.com' },
  { id: 2, account: 'user', password: '123456', username: '测试用户', role: 2, avatar: '', email: 'user@test.com' },
];

function json(body, code = 200) {
  return JSON.stringify({ code, message: code === 200 ? '操作成功' : '失败', data: body });
}
function paged(data, total) {
  return JSON.stringify({ code: 200, message: '操作成功', data, total });
}

const server = http.createServer((req, res) => {
  res.setHeader('Content-Type', 'application/json;charset=UTF-8');
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', '*');
  res.setHeader('Access-Control-Allow-Headers', '*');
  if (req.method === 'OPTIONS') return res.end();

  const u = url.parse(req.url, true);
  const path = u.pathname.replace('/api/v1.0/self-health-api', '');
  let body = '';
  req.on('data', c => body += c);
  req.on('end', () => {
    try { body = JSON.parse(body || '{}'); } catch { body = {}; }

    const token = (req.headers['authorization'] || '').replace('Bearer ', '');
    const authed = USERS.find(u => token && u.id.toString() === token);

    // ===== USER =====
    if (path === '/user/login' && req.method === 'POST') {
      const u = USERS.find(x => x.account === body.account && x.password === body.password);
      if (!u) return res.end(json('', 400));
      return res.end(json({ id: u.id, token: String(u.id), role: u.role }));
    }
    if (path === '/user/auth' && req.method === 'GET') {
      if (!authed) return res.end(json('', 400));
      return res.end(json(authed));
    }
    if (path === '/user/query' && req.method === 'POST') {
      return res.end(paged(USERS, USERS.length));
    }
    if (path.startsWith('/user/') && req.method === 'PUT') {
      return res.end(json('修改成功'));
    }
    if (path === '/user/updatePassword' && req.method === 'PUT') {
      return res.end(json('密码修改成功，请重新登录'));
    }

    // ===== DASHBOARD =====
    if (path === '/dashboard/staticCount') {
      return res.end(json({ userCount: 2, modelCount: 5, healthNewsCount: 12, recipeCount: 8 }));
    }

    // ===== HEALTH RECORD =====
    if (path === '/health-record/list' && req.method === 'GET') {
      return res.end(paged([], 0));
    }
    if (path === '/health-record/list' && req.method === 'POST') {
      return res.end(paged([], 0));
    }

    // ===== DIET HISTORY =====
    if (path === '/diet-history/list' && req.method === 'GET') {
      return res.end(paged([], 0));
    }

    // ===== HEALTH NEWS =====
    if (path === '/health-news/list' && req.method === 'POST') {
      return res.end(paged([], 0));
    }

    // ===== HEALTH MODEL =====
    if (path === '/health-model/list' && req.method === 'POST') {
      return res.end(paged([{ id: 1, name: '血压', unit: 'mmHg', normalValue: '90,140' }], 1));
    }

    // ===== EVALUATIONS =====
    if (path === '/evaluations/list' && req.method === 'POST') {
      return res.end(paged([], 0));
    }
    if (path === '/evaluations/query' && req.method === 'POST') {
      return res.end(paged([], 0));
    }

    // ===== RECIPE =====
    if (path === '/recipe/list' && req.method === 'POST') {
      return res.end(paged([], 0));
    }

    // ===== AI CHAT =====
    if (path === '/ai-chat/send' && req.method === 'POST') {
      return res.end(json('您好！根据您的健康数据，建议您保持均衡饮食和适当运动。如有具体问题，欢迎随时咨询。'));
    }
    if (path === '/ai-chat/daily-summary' && req.method === 'GET') {
      return res.end(json('【今日总结】饮食：暂无记录。健康指标：暂无数据。建议：请注意记录今日饮食和健康数据。'));
    }
    if (path === '/ai-chat/reminder' && req.method === 'GET') {
      return res.end(json(''));
    }

    // fallback
    res.writeHead(404);
    res.end(json({ error: 'not found:' + path }, 404));
  });
});

server.listen(PORT, () => console.log(`Mock backend running on http://localhost:${PORT}`));
