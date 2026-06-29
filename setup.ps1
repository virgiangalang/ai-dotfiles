# Claude Code Dotfiles — Windows Setup Script
# Supports: Claude Code, Claude Desktop, Cursor, Codex, Windsurf
# Usage: .\setup.ps1

param(
    [switch]$ClaudeCode,
    [switch]$ClaudeDesktop,
    [switch]$Cursor,
    [switch]$All
)

# Default: install semua kalau tidak ada flag
if (-not $ClaudeCode -and -not $ClaudeDesktop -and -not $Cursor) {
    $All = $true
}

$REPO = $PSScriptRoot
Write-Host "Galang's AI Dotfiles Setup (Windows)" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# ─── CLAUDE CODE ─────────────────────────────────────────────
if ($All -or $ClaudeCode) {
    Write-Host "`n[Claude Code]" -ForegroundColor Yellow
    $claudeDir = "$env:USERPROFILE\.claude"
    New-Item -ItemType Directory -Force $claudeDir | Out-Null

    Copy-Item -Force "$REPO\claude-code\settings.json" "$claudeDir\settings.json"
    Write-Host "  settings.json copied" -ForegroundColor Green

    # Install gstack skill
    $gstackDir = "$claudeDir\skills\gstack"
    if (-not (Test-Path $gstackDir)) {
        Write-Host "  Cloning gstack skill..." -ForegroundColor Gray
        git clone https://github.com/garrytan/gstack.git $gstackDir --quiet
        Write-Host "  gstack installed" -ForegroundColor Green
    } else {
        Write-Host "  gstack already exists (skip)" -ForegroundColor Gray
    }

    # Copy custom skills ke ~/.claude/skills/ (available di Claude Code)
    $skillsDest = "$claudeDir\skills"
    New-Item -ItemType Directory -Force $skillsDest | Out-Null
    Get-ChildItem "$REPO\claude-desktop\skills" -Directory | ForEach-Object {
        Copy-Item -Recurse -Force $_.FullName "$skillsDest\$($_.Name)"
    }
    Write-Host "  14 custom skills copied to ~/.claude/skills/" -ForegroundColor Green

    # Install ECC rules (common + typescript + react) — dari repo, no internet needed
    Write-Host "  Installing ECC rules..." -ForegroundColor Gray
    $rulesDir = "$claudeDir\rules\ecc"
    New-Item -ItemType Directory -Force $rulesDir | Out-Null
    foreach ($ruleset in @("common", "typescript", "react")) {
        if (Test-Path "$REPO\ecc-rules\$ruleset") {
            Copy-Item -Recurse -Force "$REPO\ecc-rules\$ruleset" "$rulesDir\$ruleset"
        }
    }
    Write-Host "  ECC rules installed to ~/.claude/rules/ecc/" -ForegroundColor Green

    # Install ALL 271 ECC skills
    Write-Host "  Installing ECC skills (271)..." -ForegroundColor Gray
    if (Test-Path "$REPO\ecc-skills") {
        Get-ChildItem "$REPO\ecc-skills" -Directory | ForEach-Object {
            Copy-Item -Recurse -Force $_.FullName "$skillsDest\$($_.Name)"
        }
        Write-Host "  ECC skills installed to ~/.claude/skills/" -ForegroundColor Green
    }

    # Install ECC agents (67)
    Write-Host "  Installing ECC agents (67)..." -ForegroundColor Gray
    $agentsDest = "$claudeDir\agents"
    New-Item -ItemType Directory -Force $agentsDest | Out-Null
    if (Test-Path "$REPO\ecc-agents") {
        Get-ChildItem "$REPO\ecc-agents" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$agentsDest\$($_.Name)"
        }
        Write-Host "  ECC agents installed to ~/.claude/agents/" -ForegroundColor Green
    }

    # Install ECC commands (92)
    Write-Host "  Installing ECC commands (92)..." -ForegroundColor Gray
    $commandsDest = "$claudeDir\commands"
    New-Item -ItemType Directory -Force $commandsDest | Out-Null
    if (Test-Path "$REPO\ecc-commands") {
        Get-ChildItem "$REPO\ecc-commands" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$commandsDest\$($_.Name)"
        }
        Write-Host "  ECC commands installed to ~/.claude/commands/" -ForegroundColor Green
    }

    # Install Superpowers skills + hooks
    Write-Host "  Installing Superpowers skills..." -ForegroundColor Gray
    if (Test-Path "$REPO\superpowers-skills") {
        Get-ChildItem "$REPO\superpowers-skills" -Directory | ForEach-Object {
            Copy-Item -Recurse -Force $_.FullName "$skillsDest\$($_.Name)"
        }
    }
    $hooksDir = "$claudeDir\hooks"
    New-Item -ItemType Directory -Force $hooksDir | Out-Null
    if (Test-Path "$REPO\superpowers-hooks") {
        Get-ChildItem "$REPO\superpowers-hooks" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$hooksDir\$($_.Name)"
        }
    }
    Write-Host "  Superpowers installed" -ForegroundColor Green

    # Install Claude-Mem skills + hooks + modes
    Write-Host "  Installing Claude-Mem skills..." -ForegroundColor Gray
    if (Test-Path "$REPO\claudemem-skills") {
        Get-ChildItem "$REPO\claudemem-skills" -Directory | ForEach-Object {
            Copy-Item -Recurse -Force $_.FullName "$skillsDest\$($_.Name)"
        }
    }
    if (Test-Path "$REPO\claudemem-hooks") {
        Get-ChildItem "$REPO\claudemem-hooks" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$hooksDir\$($_.Name)"
        }
    }
    $modesDir = "$claudeDir\modes"
    New-Item -ItemType Directory -Force $modesDir | Out-Null
    if (Test-Path "$REPO\claudemem-modes") {
        Get-ChildItem "$REPO\claudemem-modes" -Directory | ForEach-Object {
            Copy-Item -Recurse -Force $_.FullName "$modesDir\$($_.Name)"
        }
    }
    Write-Host "  Claude-Mem installed" -ForegroundColor Green

    # Install Ruflo skills + agents + commands (semua 35 plugins)
    Write-Host "  Installing Ruflo skills/agents/commands..." -ForegroundColor Gray
    if (Test-Path "$REPO\ruflo-skills") {
        Get-ChildItem "$REPO\ruflo-skills" -Directory | ForEach-Object {
            Copy-Item -Recurse -Force $_.FullName "$skillsDest\$($_.Name)"
        }
    }
    if (Test-Path "$REPO\ruflo-agents") {
        Get-ChildItem "$REPO\ruflo-agents" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$agentsDest\$($_.Name)"
        }
    }
    if (Test-Path "$REPO\ruflo-commands") {
        Get-ChildItem "$REPO\ruflo-commands" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$commandsDest\$($_.Name)"
        }
    }
    Write-Host "  Ruflo installed" -ForegroundColor Green

    # Install Anthropic official plugins (frontend-design, code-review, security-guidance, hookify, dll)
    Write-Host "  Installing Anthropic official plugin content..." -ForegroundColor Gray
    if (Test-Path "$REPO\anthropic-skills") {
        Get-ChildItem "$REPO\anthropic-skills" -Directory | ForEach-Object {
            Copy-Item -Recurse -Force $_.FullName "$skillsDest\$($_.Name)"
        }
    }
    if (Test-Path "$REPO\anthropic-agents") {
        Get-ChildItem "$REPO\anthropic-agents" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$agentsDest\$($_.Name)"
        }
    }
    if (Test-Path "$REPO\anthropic-commands") {
        Get-ChildItem "$REPO\anthropic-commands" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$commandsDest\$($_.Name)"
        }
    }
    if (Test-Path "$REPO\anthropic-hooks") {
        Get-ChildItem "$REPO\anthropic-hooks" -File | ForEach-Object {
            Copy-Item -Force $_.FullName "$hooksDir\$($_.Name)"
        }
    }
    Write-Host "  Anthropic official plugins installed" -ForegroundColor Green

    # MCP: ruflo-rag-memory
    Write-Host "  Untuk tambah ruflo MCP ke project, masuk folder project lalu:" -ForegroundColor Gray
    Write-Host "    claude mcp add ruflo -- npx ruflo@latest mcp start" -ForegroundColor White
}

# ─── CLAUDE DESKTOP ──────────────────────────────────────────
if ($All -or $ClaudeDesktop) {
    Write-Host "`n[Claude Desktop Skills]" -ForegroundColor Yellow
    $desktopSkillsBase = "$env:APPDATA\Claude\local-agent-mode-sessions\skills-plugin"

    if (Test-Path $desktopSkillsBase) {
        # Cari existing skills directory
        $existing = Get-ChildItem "$desktopSkillsBase\*\*\skills" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($existing) {
            Get-ChildItem "$REPO\claude-desktop\skills" -Directory | ForEach-Object {
                Copy-Item -Recurse -Force $_.FullName "$($existing.FullName)\$($_.Name)"
            }
            Write-Host "  Skills copied to Claude Desktop" -ForegroundColor Green
        } else {
            Write-Host "  Claude Desktop skills dir belum ada — buka Claude Desktop dulu sekali, lalu jalankan setup lagi" -ForegroundColor Gray
        }
    } else {
        Write-Host "  Claude Desktop tidak terdeteksi di AppData" -ForegroundColor Gray
    }
}

# ─── CURSOR ──────────────────────────────────────────────────
if ($All -or $Cursor) {
    Write-Host "`n[Cursor]" -ForegroundColor Yellow
    $cursorDir = "$env:USERPROFILE\.cursor"
    New-Item -ItemType Directory -Force $cursorDir | Out-Null

    Copy-Item -Force "$REPO\cursor\mcp.json" "$cursorDir\mcp.json"
    Write-Host "  mcp.json copied (~/.cursor/mcp.json)" -ForegroundColor Green
    Write-Host "  Copy cursor/rules.md ke .cursorrules di project root kalau perlu" -ForegroundColor Gray
}

# ─── CODEX / WINDSURF ────────────────────────────────────────
Write-Host "`n[Codex / Windsurf]" -ForegroundColor Yellow
Write-Host "  Copy codex/AGENTS.md ke root project sebagai AGENTS.md" -ForegroundColor Gray
Write-Host "  Copy windsurf/rules.md ke .windsurfrules di project root" -ForegroundColor Gray

Write-Host "`nSetup selesai! Restart Claude Code." -ForegroundColor Cyan
Write-Host "Plugins (ECC, ruflo-rag-memory, superpowers, dll) auto-download saat Claude Code restart." -ForegroundColor Gray
Write-Host "Node.js (v18+) harus terinstall untuk ruflo MCP." -ForegroundColor Gray
