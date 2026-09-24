#!/usr/bin/env bash
# KnowSex 静态站构建：克隆上游 → pnpm install + astro build → site/
set -euo pipefail

VERSION="${LAZYCAT_VERSION:-${VERSION:-}}"
echo "==> building knowsex version: ${VERSION:-<default branch>}"

rm -rf .upstream dist site
if [ -n "$VERSION" ]; then
  if ! git clone --depth 1 --branch "$VERSION" https://github.com/knowsex/knowsex.github.io.git .upstream 2>/dev/null; then
    echo "==> tag $VERSION not found, falling back to default branch"
    git clone --depth 1 https://github.com/knowsex/knowsex.github.io.git .upstream
  fi
else
  git clone --depth 1 https://github.com/knowsex/knowsex.github.io.git .upstream
fi

corepack enable 2>/dev/null || true
cd .upstream
pnpm install --frozen-lockfile
pnpm build
cd ..
cp -r .upstream/dist site
echo "==> site built: $(du -sh site | cut -f1)"
