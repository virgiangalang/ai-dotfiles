#!/bin/bash
# Claude Code Dotfiles — Mac/Linux Setup Script
# Supports: Claude Code, Claude Desktop, Cursor, Codex, Windsurf
# Usage: bash setup.sh [--claude-code] [--cursor] [--all]

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALL=true

for arg in "$@"; do
    case $arg in
        --claude-code) CLAUDE_CODE=true; ALL=false ;;
        --cursor) CURSOR=true; ALL=false ;;
        --claude-desktop) CLAUDE_DESKTOP=true; ALL=false ;;
    esac
done

echo "Galang's AI Dotfiles Setup (Mac/Linux)"
echo "======================================"

# ─── CLAUDE CODE ─────────────────────────────────────────────
if [ "$ALL" = true ] || [ "$CLAUDE_CODE" = true ]; then
    echo ""
    echo "[Claude Code]"
    CLAUDE_DIR="$HOME/.claude"
    mkdir -p "$CLAUDE_DIR/skills"

    cp -f "$REPO/claude-code/settings.json" "$CLAUDE_DIR/settings.json"
    echo "  ✓ settings.json copied"

    # Install gstack skill
    GSTACK_DIR="$CLAUDE_DIR/skills/gstack"
    if [ ! -d "$GSTACK_DIR" ]; then
        echo "  Cloning gstack skill..."
        git clone https://github.com/garrytan/gstack.git "$GSTACK_DIR" --quiet
        echo "  ✓ gstack installed"
    else
        echo "  gstack already exists (skip)"
    fi

    # Copy 16 custom skills ke ~/.claude/skills/
    for skill_dir in "$REPO/claude-desktop/skills"/*/; do
        skill_name=$(basename "$skill_dir")
        cp -rf "$skill_dir" "$CLAUDE_DIR/skills/$skill_name"
    done
    echo "  ✓ Custom skills copied to ~/.claude/skills/"

    # Install business agents (CEO advisor, PM, solution engineer, market researcher, etc.)
    echo "  Installing business agents..."
    mkdir -p "$CLAUDE_DIR/agents"
    if [ -d "$REPO/business-agents" ]; then
        cp -f "$REPO/business-agents"/* "$CLAUDE_DIR/agents/" 2>/dev/null
        echo "  ✓ Business agents installed to ~/.claude/agents/"
    fi

    # Install business commands (/biz-plan, /market-analysis, /okr-workshop, etc.)
    echo "  Installing business commands..."
    mkdir -p "$CLAUDE_DIR/commands"
    if [ -d "$REPO/business-commands" ]; then
        cp -f "$REPO/business-commands"/* "$CLAUDE_DIR/commands/" 2>/dev/null
        echo "  ✓ Business commands installed to ~/.claude/commands/"
    fi

    # Install ECC rules (common + typescript + react) — dari repo, no internet needed
    echo "  Installing ECC rules..."
    RULES_DIR="$CLAUDE_DIR/rules/ecc"
    mkdir -p "$RULES_DIR"
    for ruleset in common typescript react; do
        [ -d "$REPO/ecc-rules/$ruleset" ] && cp -rf "$REPO/ecc-rules/$ruleset" "$RULES_DIR/$ruleset"
    done
    echo "  ✓ ECC rules installed to ~/.claude/rules/ecc/"

    # Install ALL 271 ECC skills
    echo "  Installing ECC skills (271)..."
    if [ -d "$REPO/ecc-skills" ]; then
        for skill_dir in "$REPO/ecc-skills"/*/; do
            skill_name=$(basename "$skill_dir")
            cp -rf "$skill_dir" "$CLAUDE_DIR/skills/$skill_name"
        done
        echo "  ✓ ECC skills installed to ~/.claude/skills/"
    fi

    # Install ECC agents (67)
    echo "  Installing ECC agents (67)..."
    mkdir -p "$CLAUDE_DIR/agents"
    if [ -d "$REPO/ecc-agents" ]; then
        cp -f "$REPO/ecc-agents"/* "$CLAUDE_DIR/agents/" 2>/dev/null
        echo "  ✓ ECC agents installed to ~/.claude/agents/"
    fi

    # Install ECC commands (92)
    echo "  Installing ECC commands (92)..."
    mkdir -p "$CLAUDE_DIR/commands"
    if [ -d "$REPO/ecc-commands" ]; then
        cp -f "$REPO/ecc-commands"/* "$CLAUDE_DIR/commands/" 2>/dev/null
        echo "  ✓ ECC commands installed to ~/.claude/commands/"
    fi

    # Install Superpowers skills + hooks
    echo "  Installing Superpowers skills..."
    [ -d "$REPO/superpowers-skills" ] && for d in "$REPO/superpowers-skills"/*/; do cp -rf "$d" "$CLAUDE_DIR/skills/$(basename $d)"; done
    mkdir -p "$CLAUDE_DIR/hooks"
    [ -d "$REPO/superpowers-hooks" ] && cp -f "$REPO/superpowers-hooks"/* "$CLAUDE_DIR/hooks/" 2>/dev/null
    echo "  ✓ Superpowers installed"

    # Install Claude-Mem skills + hooks + modes
    echo "  Installing Claude-Mem skills..."
    [ -d "$REPO/claudemem-skills" ] && for d in "$REPO/claudemem-skills"/*/; do cp -rf "$d" "$CLAUDE_DIR/skills/$(basename $d)"; done
    [ -d "$REPO/claudemem-hooks" ] && cp -f "$REPO/claudemem-hooks"/* "$CLAUDE_DIR/hooks/" 2>/dev/null
    mkdir -p "$CLAUDE_DIR/modes"
    [ -d "$REPO/claudemem-modes" ] && for d in "$REPO/claudemem-modes"/*/; do cp -rf "$d" "$CLAUDE_DIR/modes/$(basename $d)"; done
    echo "  ✓ Claude-Mem installed"

    # Install Ruflo skills + agents + commands (semua 35 plugins)
    echo "  Installing Ruflo skills/agents/commands..."
    [ -d "$REPO/ruflo-skills" ] && for d in "$REPO/ruflo-skills"/*/; do cp -rf "$d" "$CLAUDE_DIR/skills/$(basename $d)"; done
    [ -d "$REPO/ruflo-agents" ] && cp -f "$REPO/ruflo-agents"/* "$CLAUDE_DIR/agents/" 2>/dev/null
    [ -d "$REPO/ruflo-commands" ] && cp -f "$REPO/ruflo-commands"/* "$CLAUDE_DIR/commands/" 2>/dev/null
    echo "  ✓ Ruflo installed"

    # Install Anthropic official plugins (frontend-design, code-review, security-guidance, hookify, dll)
    echo "  Installing Anthropic official plugin content..."
    [ -d "$REPO/anthropic-skills" ] && for d in "$REPO/anthropic-skills"/*/; do cp -rf "$d" "$CLAUDE_DIR/skills/$(basename $d)"; done
    [ -d "$REPO/anthropic-agents" ] && cp -f "$REPO/anthropic-agents"/* "$CLAUDE_DIR/agents/" 2>/dev/null
    [ -d "$REPO/anthropic-commands" ] && cp -f "$REPO/anthropic-commands"/* "$CLAUDE_DIR/commands/" 2>/dev/null
    [ -d "$REPO/anthropic-hooks" ] && cp -f "$REPO/anthropic-hooks"/* "$CLAUDE_DIR/hooks/" 2>/dev/null
    echo "  ✓ Anthropic official plugins installed"

    echo "  → Untuk ruflo MCP, masuk folder project lalu:"
    echo "    claude mcp add ruflo -- npx ruflo@latest mcp start"
fi

# ─── CLAUDE DESKTOP ──────────────────────────────────────────
if [ "$ALL" = true ] || [ "$CLAUDE_DESKTOP" = true ]; then
    echo ""
    echo "[Claude Desktop Skills]"

    # Mac path
    DESKTOP_BASE="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"
    if [ -d "$DESKTOP_BASE" ]; then
        EXISTING=$(find "$DESKTOP_BASE" -type d -name "skills" 2>/dev/null | head -1)
        if [ -n "$EXISTING" ]; then
            cp -rf "$REPO/claude-desktop/skills/"* "$EXISTING/"
            echo "  ✓ Skills copied to Claude Desktop"
        else
            echo "  Claude Desktop skills dir belum ada — buka Claude Desktop dulu sekali"
        fi
    else
        echo "  Claude Desktop tidak terdeteksi"
    fi
fi

# ─── CURSOR ──────────────────────────────────────────────────
if [ "$ALL" = true ] || [ "$CURSOR" = true ]; then
    echo ""
    echo "[Cursor]"
    mkdir -p "$HOME/.cursor"
    cp -f "$REPO/cursor/mcp.json" "$HOME/.cursor/mcp.json"
    echo "  ✓ mcp.json copied (~/.cursor/mcp.json)"
    echo "  → Copy cursor/rules.md ke .cursorrules di project root"
fi

# ─── CODEX / WINDSURF ────────────────────────────────────────
echo ""
echo "[Codex / Windsurf]"
echo "  → Copy codex/AGENTS.md ke root project sebagai AGENTS.md"
echo "  → Copy windsurf/rules.md ke .windsurfrules di project root"

echo ""
echo "Setup selesai! Restart Claude Code."
echo "Plugins (ECC, ruflo-rag-memory, superpowers, dll) auto-download saat restart."
echo "Node.js (v18+) harus terinstall untuk ruflo MCP."
