#!/usr/bin/env bash
# GitHub 一键部署：建仓库 → 推送 → 开启 Pages
# 用法：
#   GITHUB_USER=你的用户名 GITHUB_TOKEN=ghp_xxx ./deploy-gh.sh [仓库名]
# Token 需要 repo 权限（classic）或对 Contents/Pages/Administration 有 Read & Write（fine-grained）
set -euo pipefail

REPO="${1:-resume}"
: "${GITHUB_USER:?请设置 GITHUB_USER}"
: "${GITHUB_TOKEN:?请设置 GITHUB_TOKEN}"

API="https://api.github.com"
AUTH=(-H "Authorization: Bearer ${GITHUB_TOKEN}" -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28")

echo "==> 1/4 检查本地仓库"
if [ ! -f index.html ]; then
  echo "错误：当前目录没有 index.html，请在 resume-web 目录下运行" >&2
  exit 1
fi
git rev-parse --git-dir >/dev/null 2>&1 || { git init -q; git add -A; git commit -qm "init"; }

echo "==> 2/4 创建仓库 ${GITHUB_USER}/${REPO}（已存在则跳过）"
code=$(curl -s -o /tmp/gh_create.json -w "%{http_code}" -X POST "${API}/user/repos" "${AUTH[@]}" \
  -d "{\"name\":\"${REPO}\",\"description\":\"Matthew Yang - Technical Recruiter (Algorithm / Embodied AI)\",\"private\":false,\"auto_init\":false}")
if [ "$code" = "201" ]; then
  echo "    仓库已创建"
elif [ "$code" = "422" ]; then
  echo "    仓库已存在，继续推送"
else
  echo "    创建失败（HTTP $code）：" >&2
  cat /tmp/gh_create.json >&2; exit 1
fi

echo "==> 3/4 推送到 main"
git branch -M main
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO}.git"
git push -u origin main --quiet
git remote set-url origin "https://github.com/${GITHUB_USER}/${REPO}.git"   # 推送后移除 URL 中的 token
echo "    推送完成"

echo "==> 4/4 开启 GitHub Pages"
code=$(curl -s -o /tmp/gh_pages.json -w "%{http_code}" -X POST "${API}/repos/${GITHUB_USER}/${REPO}/pages" "${AUTH[@]}" \
  -d '{"source":{"branch":"main","path":"/"}}')
if [ "$code" = "201" ]; then
  echo "    Pages 已开启"
elif [ "$code" = "409" ]; then
  echo "    Pages 已存在，跳过"
else
  echo "    Pages 开启失败（HTTP $code）：" >&2
  cat /tmp/gh_pages.json >&2
fi

echo ""
echo "访问地址（首次部署约需 1 分钟生效）："
echo "  https://${GITHUB_USER}.github.io/${REPO}/"
