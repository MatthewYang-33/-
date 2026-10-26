# 杨天赐 · 网页简历

猎头顾问（算法 / 具身智能方向）单页网页简历。纯静态、零依赖、单文件，可直接托管在 GitHub Pages。

## 文件说明

| 文件 | 说明 |
|---|---|
| `index.html` | 完整网页（HTML + CSS + JS 全内嵌，无外部依赖） |
| `.gitignore` | 忽略系统杂项文件 |

## 功能特点

- 响应式：桌面双栏信息布局，手机自动堆叠
- 打印优化：`@media print` 适配 A4，点「打印 / 存 PDF」可直接导出 PDF 简历
- 一键复制邮箱、滚动导航高亮、滚动淡入动效（支持 `prefers-reduced-motion`）
- 无外部字体与 CDN，离线可用

## 需要补充的内容

页面中标记为 `待补充`（带虚线底纹）的地方需要填写真实数据：

1. `核心业绩` 中的「累计成功入职人数」
2. `工作经历` → 猎头顾问 → 「客户类型」（如机器人整机厂 / 自动驾驶 / 大模型团队）
3. 如需更具体，可补充：服务客户数量、年推荐候选人数、平均关闭周期

## 部署到 GitHub Pages

### 方式一：网页上传（最简单）

1. 在 GitHub 新建仓库，命名如 `resume`，可见性选 Public
2. 进入仓库 → `Add file` → `Upload files` → 拖入 `index.html`
3. 仓库 `Settings` → `Pages` → Source 选 `Deploy from a branch`，Branch 选 `main` / `root` → Save
4. 约 1 分钟后访问：`https://<你的用户名>.github.io/resume/`

### 方式二：命令行推送

```bash
cd resume-web
git remote add origin https://github.com/<你的用户名>/resume.git
git branch -M main
git push -u origin main
```

推送后在仓库 `Settings → Pages` 开启分支部署即可。

> 若仓库命名为 `<你的用户名>.github.io`，访问地址直接是 `https://<你的用户名>.github.io/`。

### 方式三：GitHub Desktop

用 GitHub Desktop 打开本目录 → Publish repository → 勾选 Public → 发布后在网页端开启 Pages。

## 自定义样式

所有配色集中在 `:root`：

| 变量 | 当前值 | 用途 |
|---|---|---|
| `--ink` | `#0F172A` | 主文字 / 头部底色 |
| `--brand` | `#1D4ED8` | 强调色（标题条、职位名、主要按钮） |
| `--gold` | `#B4690E` | 「待补充」标记色 |
| `--bg` | `#F6F7F9` | 页面底色 |

改一处即可整体换色，例如换成深绿 `#0F6E56` 或酒红 `#993556`。
