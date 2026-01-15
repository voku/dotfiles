#!/usr/bin/env bash

# Test script for Blind Spot Architect
# This script provides automated inputs to test the blind-spot-architect.sh script

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BSA_SCRIPT="$SCRIPT_DIR/../bin/blind-spot-architect.sh"

echo "Testing Blind Spot Architect..."
echo ""

# Create a test input file with all the answers
cat <<'EOF' | "$BSA_SCRIPT"
.zshrc and .aliases files
The README claims all features are documented but many aliases lack explanation
Many aliases in .aliases are not mentioned in any documentation
Last month
About 30 percent
Yes
To have every function and alias properly documented with examples
I don't have time right now, I'm working on other projects
Working on my main job projects and other open source contributions
EOF

echo ""
echo "Test completed successfully!"
