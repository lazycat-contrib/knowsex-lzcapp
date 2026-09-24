# KnowSex (LazyCat)

性知识科普网站（Astro 构建），打包为 LazyCat LPK v2 静态应用。上游项目：[knowsex/knowsex.github.io](https://github.com/knowsex/knowsex.github.io)。

> 仅作镜像打包，不修改任何内容（遵循上游《镜像站部署协议》）。

## 部署信息

- **包名**：`cloud.lazycat.app.knowsex`
- **版本**：跟随上游 main 分支自动更新（每日 UTC 02:00 检查，北京时间 10:00）
- **类型**：纯静态站（Astro 4 + pnpm 构建，无后端服务）
- **min_os_version**：1.5.0
- **内容**：约 37 MB（63 个页面）

## 自动更新机制

上游没有 release tag，`sync-upstream` job 每日比对 main 分支 HEAD commit SHA（`.upstream-sha` 记录上次构建值），变化则 bump patch（1.0.0 → 1.0.1 …）并 push 触发发布。

```
上游 knowsex/knowsex.github.io (main)
   │  schedule 检查 HEAD SHA → 变化则 bump patch → push
   ▼
本仓库（LPK 配置 + build.sh）
   │  push 触发 → ca-x/lazycat-github-action（node 22 toolchain）
   │  buildscript: clone 上游 → pnpm install --frozen-lockfile → pnpm build → site/
   ▼
LPK 打包（contentdir: ./site）→ GitHub Release + 喵喵商店发布
```

## 文件结构

```
package.yml              # 包元数据
lzc-manifest.yml         # 运行结构（file:// 静态服务）
lzc-build.yml            # 构建配置（contentdir + buildscript）
build.sh                 # CI 构建脚本（clone 上游 + pnpm/astro build）
.upstream-sha            # 上次构建的上游 commit SHA
icon.png                 # 应用图标
.github/lazycat-action.yml      # Action 配置（git 版本源 / node toolchain / 喵喵商店）
.github/workflows/lazycat.yml   # 上游同步 + 发布工作流
```
