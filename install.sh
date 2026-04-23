#!/usr/bin/env bash
# Ray Dalio Council — Install Script
# Installs the /dalio skill into Claude Code

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

echo ""
echo "  Ray Dalio Council"
echo "  Believability-weighted decision council for Claude Code"
echo "  ─────────────────────────────────────────────────────────"
echo ""

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Install the skill
cp "$SCRIPT_DIR/dalio-council.md" "$SKILLS_DIR/dalio-council.md"

echo "  Installed: $SKILLS_DIR/dalio-council.md"
echo ""
echo "  Usage:"
echo "    /dalio Should we launch the referral program this week?"
echo "    /dalio context: \"bootstrapped SaaS, 150 users\" -- Should we hire?"
echo ""
echo "  The council runs 5 scouts, weighs their inputs, and returns"
echo "  a PROCEED / HOLD / INVESTIGATE verdict with confidence score."
echo ""
echo "  Done."
echo ""
