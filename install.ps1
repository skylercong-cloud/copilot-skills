<#
.SYNOPSIS
  Install a Copilot skill (and its prompts) to user-global locations.

.DESCRIPTION
  Downloads this repo (git or zip), then copies the requested skill into:
    - %USERPROFILE%\.copilot\skills\<name>\
  And associated prompt files into:
    - %APPDATA%\Code\User\prompts\

.PARAMETER Skill
  Name of the skill folder under skills/ . Default: shopify-page-dev

.PARAMETER Repo
  Git URL of the copilot-skills repo. Default points to the public repo.

.PARAMETER Ref
  Branch / tag / commit to install from. Default: main

.PARAMETER Force
  Overwrite existing files (skill dir + prompt files).

.PARAMETER NoPrompts
  Skip installing prompt files into VS Code prompts dir.

.PARAMETER List
  Print available skills from manifest.json and exit.

.EXAMPLE
  irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1 | iex

.EXAMPLE
  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.ps1))) -Skill shopify-page-dev -Force
#>
[CmdletBinding()]
param(
  [string]$Skill = "shopify-page-dev",
  [string]$Repo = "https://github.com/skylercong-cloud/copilot-skills.git",
  [string]$Ref = "main",
  [switch]$Force,
  [switch]$NoPrompts,
  [switch]$List
)

$ErrorActionPreference = "Stop"

function Write-Section([string]$msg) { Write-Host ""; Write-Host "==> $msg" -ForegroundColor Cyan }
function Write-Ok([string]$msg) { Write-Host "  [OK] $msg" -ForegroundColor Green }
function Write-Skip([string]$msg) { Write-Host "  [SKIP] $msg" -ForegroundColor Yellow }
function Write-Warn2([string]$msg) { Write-Host "  [!] $msg" -ForegroundColor Yellow }

$skillsDir = Join-Path $env:USERPROFILE ".copilot\skills"
$promptsDir = Join-Path $env:APPDATA     "Code\User\prompts"

# ---------- 1. Fetch repo into temp ----------
Write-Section "Fetching repo $Repo ($Ref)"
$tmp = Join-Path $env:TEMP ("copilot-skills-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp | Out-Null

$haveGit = $false
try { & git --version *> $null; if ($LASTEXITCODE -eq 0) { $haveGit = $true } } catch { $haveGit = $false }

if ($haveGit) {
  # Suppress stderr-as-error noise from native git output under $ErrorActionPreference=Stop
  $prevPref = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & git clone --depth 1 --branch $Ref $Repo $tmp 2>&1 | Out-Null
  $code = $LASTEXITCODE
  $ErrorActionPreference = $prevPref
  if ($code -ne 0) { throw "git clone failed (exit $code) for $Repo @ $Ref" }
  Write-Ok "cloned via git"
}
else {
  $repoZipBase = $Repo -replace '\.git$', ''
  $zipUrl = "$repoZipBase/archive/refs/heads/$Ref.zip"
  $zip = Join-Path $tmp "repo.zip"
  Invoke-WebRequest -Uri $zipUrl -OutFile $zip -UseBasicParsing
  Expand-Archive -Path $zip -DestinationPath $tmp -Force
  Remove-Item $zip
  $extracted = Get-ChildItem $tmp -Directory | Select-Object -First 1
  Get-ChildItem $extracted.FullName -Force | Move-Item -Destination $tmp -Force
  Remove-Item $extracted.FullName -Recurse -Force
  Write-Ok "downloaded via zip"
}

try {
  # ---------- 2. -List mode ----------
  if ($List) {
    Write-Section "Available skills"
    $manifestPath = Join-Path $tmp "manifest.json"
    if (Test-Path $manifestPath) {
      $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
      foreach ($s in $manifest.skills) {
        Write-Host ("  - {0}  (v{1})  {2}" -f $s.name, $s.version, $s.description)
      }
    }
    else {
      Write-Warn2 "manifest.json not found in repo"
    }
    return
  }

  # ---------- 3. Validate skill exists ----------
  $skillSrc = Join-Path $tmp "skills\$Skill"
  if (-not (Test-Path $skillSrc)) {
    throw "Skill '$Skill' not found in repo. Use -List to see available skills."
  }

  # ---------- 4. Install skill (excluding its prompts/ dir) ----------
  Write-Section "Installing skill: $Skill"
  $skillDst = Join-Path $skillsDir $Skill
  if ((Test-Path $skillDst) -and -not $Force) {
    Write-Warn2 "skill already installed at $skillDst"
    Write-Warn2 "rerun with -Force to overwrite"
  }
  else {
    if (Test-Path $skillDst) { Remove-Item $skillDst -Recurse -Force }
    New-Item -ItemType Directory -Path $skillDst -Force | Out-Null
    # copy everything except prompts/
    Get-ChildItem $skillSrc -Force | Where-Object { $_.Name -ne "prompts" } | ForEach-Object {
      Copy-Item $_.FullName -Destination $skillDst -Recurse -Force
    }
    Write-Ok "installed -> $skillDst"
  }

  # ---------- 5. Install prompts ----------
  if (-not $NoPrompts) {
    $promptSrc = Join-Path $skillSrc "prompts"
    if (Test-Path $promptSrc) {
      Write-Section "Installing prompts -> $promptsDir"
      if (-not (Test-Path $promptsDir)) { New-Item -ItemType Directory -Path $promptsDir -Force | Out-Null }
      $promptFiles = @()
      foreach ($p in (Get-ChildItem $promptSrc -Filter *.prompt.md -File)) {
        $target = Join-Path $promptsDir $p.Name
        if ((Test-Path $target) -and -not $Force) {
          Write-Skip "$($p.Name) (exists, use -Force)"
        }
        else {
          Copy-Item $p.FullName -Destination $target -Force
          Write-Ok $p.Name
          $promptFiles += $p.Name
        }
      }
    }
  }

  # ---------- 6. Write .installed.json ----------
  $installedMeta = @{
    skill       = $Skill
    repo        = $Repo
    ref         = $Ref
    installedAt = (Get-Date).ToString("o")
  }
  if ($haveGit) {
    try { $installedMeta.commit = (git -C $tmp rev-parse HEAD).Trim() } catch {}
  }
  $metaPath = Join-Path $skillDst ".installed.json"
  if (Test-Path $skillDst) {
    $installedMeta | ConvertTo-Json | Set-Content -Path $metaPath -Encoding UTF8
  }

  # ---------- 7. Post-install checks ----------
  Write-Section "Post-install checks"

  $figmaKey = [Environment]::GetEnvironmentVariable("FIGMA_API_KEY", "User")
  if ([string]::IsNullOrWhiteSpace($figmaKey)) {
    Write-Warn2 "FIGMA_API_KEY user environment variable is not set."
    Write-Host  '         Run:  setx FIGMA_API_KEY "figd_xxxxxxxx"' -ForegroundColor Gray
    Write-Host  '         Then reopen your terminal / VS Code.' -ForegroundColor Gray
  }
  else {
    Write-Ok "FIGMA_API_KEY is set"
  }

  $snippet = Join-Path $tmp "shared\mcp-figma.snippet.json"
  if (Test-Path $snippet) {
    Write-Warn2 "Make sure your VS Code MCP config includes the Figma server."
    Write-Host  "         Snippet to merge:" -ForegroundColor Gray
    Write-Host  ""
    Get-Content $snippet | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
    Write-Host  ""
    Write-Host  "         Add this to your project's .vscode/mcp.json or VS Code user settings.json (chat.mcp.servers)." -ForegroundColor Gray
  }

  Write-Section "Done"
  Write-Host "Skill:   $skillDst" -ForegroundColor Green
  if (-not $NoPrompts) { Write-Host "Prompts: $promptsDir" -ForegroundColor Green }
}
finally {
  if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }
}
