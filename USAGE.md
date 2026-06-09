# 使用指南（USAGE）

面向 **使用者** 与 **维护者** 两类场景，覆盖：安装 / 升级 / 卸载 / 在 VS Code 中使用 / 修改并推送新版本 / 新增 Skill。

---

## 目录

- [一、首次安装](#一首次安装)
- [二、必备配置](#二必备配置)
- [三、在 VS Code 中使用 Skill](#三在-vs-code-中使用-skill)
- [四、升级到最新版](#四升级到最新版)
- [五、卸载](#五卸载)
- [六、修改 Skill 并推送（维护者）](#六修改-skill-并推送维护者)
- [七、新增一个 Skill（维护者）](#七新增一个-skill维护者)
- [八、常见问题](#八常见问题)

---

## 一、首次安装

### Windows（PowerShell）

```powershell
irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1 | iex
```

### macOS / Linux（bash）

```bash
curl -fsSL https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.sh | bash
```

### 安装位置

| 资源    | Windows                                 | macOS                                              | Linux                          |
| ------- | --------------------------------------- | -------------------------------------------------- | ------------------------------ |
| Skill   | `%USERPROFILE%\.copilot\skills\<name>\` | `~/.copilot/skills/<name>/`                        | `~/.copilot/skills/<name>/`    |
| Prompts | `%APPDATA%\Code\User\prompts\`          | `~/Library/Application Support/Code/User/prompts/` | `~/.config/Code/User/prompts/` |

> 用户级安装：装一次，**所有项目**都能用，新项目无需任何配置。

### 网络受限的离线 / Zip 安装

如果 `git clone github.com:443` 不通（公司网络/无代理），用 zip 后备方式：

```powershell
$tmp = Join-Path $env:TEMP ("cs-" + [guid]::NewGuid())
New-Item -ItemType Directory $tmp | Out-Null
Invoke-WebRequest "https://github.com/skylercong-cloud/copilot-skills/archive/refs/heads/main.zip" -OutFile "$tmp\repo.zip"
Expand-Archive "$tmp\repo.zip" -DestinationPath $tmp -Force
$src  = (Get-ChildItem $tmp -Directory)[0].FullName
$skill = "shopify-page-dev"
$dst  = "$env:USERPROFILE\.copilot\skills\$skill"
if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
New-Item -ItemType Directory $dst -Force | Out-Null
Get-ChildItem "$src\skills\$skill" -Force | Where-Object { $_.Name -ne "prompts" } |
  ForEach-Object { Copy-Item $_.FullName $dst -Recurse -Force }
$pdst = "$env:APPDATA\Code\User\prompts"
if (-not (Test-Path $pdst)) { New-Item -ItemType Directory $pdst -Force | Out-Null }
Get-ChildItem "$src\skills\$skill\prompts" -Filter *.prompt.md | ForEach-Object { Copy-Item $_.FullName $pdst -Force }
Remove-Item $tmp -Recurse -Force
```

---

## 二、必备配置

### 1. 设置 Figma API Key（仅 `shopify-page-dev` 需要）

到 https://www.figma.com/developers/api#access-tokens 生成一个 token（前缀 `figd_`），然后：

**Windows**

```powershell
setx FIGMA_API_KEY "figd_xxxxxxxxxx"
# 重开终端 / VS Code 后生效
```

**macOS / Linux**

```bash
echo 'export FIGMA_API_KEY="figd_xxxxxxxxxx"' >> ~/.zshrc   # 或 ~/.bashrc
source ~/.zshrc
```

### 2. 在新项目里配置 Figma MCP

每个新项目根目录建 `.vscode/mcp.json`：

```jsonc
{
  "servers": {
    "Figma": {
      "type": "stdio",
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "-y",
        "figma-developer-mcp",
        "--figma-api-key=${env:FIGMA_API_KEY}",
        "--stdio",
      ],
    },
  },
}
```

> 不要把真实的 API Key 写进文件，永远用 `${env:FIGMA_API_KEY}` 引用环境变量。

> 如果不想每个项目都配，可把上面的 `servers.Figma` 段合并到 VS Code **用户级** `settings.json` 的 `chat.mcp.servers` 字段里，全局生效。

### 3. 重启 VS Code

让它重新扫描 prompts 目录与 MCP 配置。

---

## 三、在 VS Code 中使用 Skill

### 方式 A：Slash 命令（推荐）

在 Copilot Chat 输入 `/`，列表里应出现 **`/dev-page`**。点击或输入后按提示填：

- 页面名称（如 `h16-pro-steam`）
- Figma PC URL
- Figma Mobile URL
- 设计宽度（PC / Mobile）

它会按 `SKILL.md` 的 9 步流程执行：抓 Figma → 生成 design analysis → 匹配 section → 写 template JSON → 写 SCSS → 注册构建 → 更新知识库。

### 方式 B：自然语言触发

直接对 Copilot 说：

```
帮我用 shopify-page-dev 开发新页面
- 页面名: my-new-page
- Figma PC: https://www.figma.com/design/xxx?node-id=0-1889
- Figma MB: https://www.figma.com/design/xxx?node-id=0-2000
- 设计宽度: PC 2560 / MB 390
```

Copilot 应在回复开头声明引用了 `shopify-page-dev` skill。

### 验证 Skill 已加载

```powershell
# Windows
Get-ChildItem "$env:USERPROFILE\.copilot\skills" -Recurse -File
Get-ChildItem "$env:APPDATA\Code\User\prompts" -File
```

应能看到 `SKILL.md`、`references\*`、`dev-page.prompt.md`。

---

## 四、升级到最新版

```powershell
# Windows，加 -Force 覆盖已存在的文件
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1))) -Force
```

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.sh | bash -s -- --force
```

---

## 五、卸载

**Windows**

```powershell
Remove-Item "$env:USERPROFILE\.copilot\skills\shopify-page-dev" -Recurse -Force
Remove-Item "$env:APPDATA\Code\User\prompts\dev-page.prompt.md" -Force
```

**macOS**

```bash
rm -rf ~/.copilot/skills/shopify-page-dev
rm -f "$HOME/Library/Application Support/Code/User/prompts/dev-page.prompt.md"
```

**Linux**

```bash
rm -rf ~/.copilot/skills/shopify-page-dev
rm -f ~/.config/Code/User/prompts/dev-page.prompt.md
```

---

## 六、修改 Skill 并推送（维护者）

### 1. 克隆仓库

```powershell
git clone https://github.com/skylercong-cloud/copilot-skills.git
cd copilot-skills
```

### 2. 修改文件

| 想做的事                | 改哪里                                                    |
| ----------------------- | --------------------------------------------------------- |
| 改 Skill 主指令         | `skills/shopify-page-dev/SKILL.md`                        |
| 改 section 速查表       | `skills/shopify-page-dev/references/section-reference.md` |
| 追加设计模式经验        | `skills/shopify-page-dev/references/pattern-learnings.md` |
| 改 Slash 命令行为       | `skills/shopify-page-dev/prompts/dev-page.prompt.md`      |
| 改 Figma MCP 模板       | `shared/mcp-figma.snippet.json`                           |
| 改 Windows 安装逻辑     | `install.ps1`                                             |
| 改 macOS/Linux 安装逻辑 | `install.sh`                                              |
| 改 README 文案          | `README.md` / `USAGE.md`                                  |

### 3. 本地验证（可选，强烈建议改 install.ps1 时跑）

```powershell
# 在沙盒目录里安装一次，避免污染真实用户目录
$test = "C:\Users\$env:USERNAME\Desktop\cs-sandbox"
if (Test-Path $test) { Remove-Item $test -Recurse -Force }
New-Item -ItemType Directory "$test\Roaming\Code\User\prompts" -Force | Out-Null
$ou = $env:USERPROFILE; $oa = $env:APPDATA
$env:USERPROFILE = $test; $env:APPDATA = "$test\Roaming"
try { .\install.ps1 -Repo (Get-Location).Path -Ref main -Force }
finally { $env:USERPROFILE = $ou; $env:APPDATA = $oa }
Get-ChildItem $test -Recurse -File
Remove-Item $test -Recurse -Force
```

### 4. 提交并推送

```powershell
git add .
git commit -m "your message"
git push
```

> Token 登录：执行前先 `gh auth login`，或临时 `$env:GH_TOKEN = "ghp_xxx"; gh auth setup-git; git push`。
> ⚠️ 永远不要把 Token 贴到任何聊天 / Issue / 提交说明里。

### 5. 用户升级

推送后无需发版，所有用户重跑一次安装命令（带 `-Force`）即拿到最新版。

---

## 七、新增一个 Skill（维护者）

例：新增名为 `shopify-section-dev` 的 skill。

### 1. 创建目录与必需文件

```
skills/shopify-section-dev/
├── SKILL.md                       # 必填，含 YAML frontmatter
└── prompts/                       # 可选
    └── new-section.prompt.md
```

`SKILL.md` 顶部必须有 frontmatter：

```yaml
---
name: shopify-section-dev
description: 'Use when: ... (告诉 Copilot 何时触发这个 skill)'
---
```

### 2. 把新 skill 登记到 manifest

编辑 `manifest.json`：

```json
{
  "skills": [
    {
      "name": "shopify-page-dev",
      "description": "...",
      "version": "0.1.0",
      "prompts": ["dev-page.prompt.md"]
    },
    {
      "name": "shopify-section-dev",
      "description": "...",
      "version": "0.1.0",
      "prompts": ["new-section.prompt.md"]
    }
  ]
}
```

### 3. 提交并推送

```powershell
git add skills/shopify-section-dev manifest.json
git commit -m "feat: add shopify-section-dev skill"
git push
```

### 4. 用户安装新 skill

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1))) -Skill shopify-section-dev
```

---

## 八、常见问题

### Q1：`/dev-page` 在 Copilot Chat 看不到？

1. 确认文件存在：`Get-ChildItem "$env:APPDATA\Code\User\prompts"` 应有 `dev-page.prompt.md`
2. **完全退出 VS Code 后再打开**（不是只关闭窗口；任务栏图标右键 → 退出）
3. VS Code 设置里搜 `chat.promptFiles`，确保未被禁用

### Q2：Copilot 不识别 / 不触发 skill？

- 在新对话里**显式提一下 skill 名**：「请使用 `shopify-page-dev` skill 帮我……」
- 检查 `SKILL.md` 是否在 `~/.copilot/skills/shopify-page-dev/SKILL.md`，且顶部 frontmatter 完整

### Q3：`git clone` 一行命令安装时报 `Failed to connect to github.com port 443`？

走 zip 后备安装（见[一、首次安装](#一首次安装)末尾），或给 git 配代理：

```powershell
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```

### Q4：Figma MCP 报 401 / 找不到 token？

- `setx` 设的环境变量**只对新开的进程生效**，必须**完全重启 VS Code**
- 验证：新开终端跑 `echo $env:FIGMA_API_KEY`，能看到 `figd_...` 才算生效

### Q5：升级后 Skill 行为没变？

- 升级命令必须带 `-Force` / `--force`，否则保留旧文件
- 升级后**重启 VS Code**

### Q6：API Key 不小心泄漏了怎么办？

立即到 https://www.figma.com/settings/tokens 撤销旧 token，生成新的，重新 `setx` 即可。
