# copilot-skills

Reusable GitHub Copilot Skills (and their prompts) installable into your **user-global** Copilot skills directory.

After installing, the skills automatically work in **every** project on your machine — no per-project setup required.

## Install paths

| Resource | Windows | macOS | Linux |
|---|---|---|---|
| Skill | `%USERPROFILE%\.copilot\skills\<name>\` | `~/.copilot/skills/<name>/` | `~/.copilot/skills/<name>/` |
| Prompts | `%APPDATA%\Code\User\prompts\` | `~/Library/Application Support/Code/User/prompts/` | `~/.config/Code/User/prompts/` |

## One-line install

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1 | iex
```

With parameters (must download then invoke):

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1))) -Skill shopify-page-dev -Force
```

### macOS / Linux (bash)

```bash
curl -fsSL https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.sh | bash
```

With parameters:

```bash
curl -fsSL https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.sh | bash -s -- --skill shopify-page-dev --force
```

## Available skills

| Name | Description |
|---|---|
| `shopify-page-dev` | Build Shopify theme pages from Figma designs (template JSON + responsive SCSS) |

List from CLI:

```powershell
# Windows
& ([scriptblock]::Create((irm .../install.ps1))) -List
```

```bash
# macOS/Linux
curl -fsSL .../install.sh | bash -s -- --list
```

## Parameters

| PowerShell | bash | Description |
|---|---|---|
| `-Skill <name>` | `--skill <name>` | Which skill to install (default: `shopify-page-dev`) |
| `-Force` | `--force` | Overwrite existing files |
| `-NoPrompts` | `--no-prompts` | Skip installing prompt files into VS Code |
| `-List` | `--list` | Print available skills and exit |
| `-Ref <branch>` | `--ref <branch>` | Install from a specific branch / tag / commit (default: `main`) |

## Update

Just rerun the install command with `-Force` (or `--force`):

```powershell
& ([scriptblock]::Create((irm .../install.ps1))) -Skill shopify-page-dev -Force
```

## Uninstall

Remove the skill folder and (optionally) the installed prompt files manually:

**Windows**

```powershell
Remove-Item "$env:USERPROFILE\.copilot\skills\shopify-page-dev" -Recurse -Force
Remove-Item "$env:APPDATA\Code\User\prompts\dev-page.prompt.md"
```

**macOS / Linux**

```bash
rm -rf ~/.copilot/skills/shopify-page-dev
rm -f  "$HOME/Library/Application Support/Code/User/prompts/dev-page.prompt.md"   # macOS
rm -f  ~/.config/Code/User/prompts/dev-page.prompt.md                              # Linux
```

## Required setup

### 1. Figma API key (for `shopify-page-dev`)

Set the user environment variable `FIGMA_API_KEY`. The MCP server config references it via `${env:FIGMA_API_KEY}`, so you never commit the key to a project.

**Windows**

```powershell
setx FIGMA_API_KEY "figd_xxxxxxxxxx"
# reopen terminal / VS Code
```

**macOS / Linux**

```bash
echo 'export FIGMA_API_KEY="figd_xxxxxxxxxx"' >> ~/.zshrc   # or ~/.bashrc
source ~/.zshrc
```

### 2. Figma MCP server

Merge [shared/mcp-figma.snippet.json](shared/mcp-figma.snippet.json) into either:

- VS Code user `settings.json` → `chat.mcp.servers`, or
- Each project's `.vscode/mcp.json`

The install script will print the snippet at the end of installation as a reminder.

## Repository layout

```
copilot-skills/
├── install.ps1                 # Windows installer
├── install.sh                  # macOS/Linux installer
├── manifest.json               # List of available skills
├── shared/
│   └── mcp-figma.snippet.json  # Figma MCP server config (uses ${env:FIGMA_API_KEY})
└── skills/
    └── shopify-page-dev/
        ├── SKILL.md
        ├── references/
        │   ├── section-reference.md
        │   └── pattern-learnings.md
        ├── prompts/
        │   └── dev-page.prompt.md   # → installs to VS Code user prompts dir
        └── templates/
            └── page-dev-spec-template.md
```

## Adding a new skill

1. Create `skills/<your-skill>/SKILL.md` (with YAML frontmatter `name` + `description`)
2. Optional: put `.prompt.md` files under `skills/<your-skill>/prompts/`
3. Add an entry to `manifest.json`
4. Commit & push — installs immediately work via `--skill <your-skill>`
