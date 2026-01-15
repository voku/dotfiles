#!/usr/bin/env bash

# Test for Blind Spot Architect
# Uses shunit2 framework consistent with existing tests

BSA_SCRIPT="./bin/blind-spot-architect.sh"

setUp() {
  # Ensure the script exists and is executable
  if [ ! -x "$BSA_SCRIPT" ]; then
    echo "Error: $BSA_SCRIPT not found or not executable"
    exit 1
  fi
}

testScriptExists() {
  assertTrue "Blind Spot Architect script should exist" "[ -f $BSA_SCRIPT ]"
}

testScriptIsExecutable() {
  assertTrue "Blind Spot Architect script should be executable" "[ -x $BSA_SCRIPT ]"
}

testScriptHasValidSyntax() {
  bash -n "$BSA_SCRIPT"
  assertEquals "Script should have valid bash syntax" 0 $?
}

testScriptProducesOutput() {
  # Run with automated input
  local output=$(cat <<'EOF' | "$BSA_SCRIPT" 2>&1
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
)
  
  # Check that script produces expected output sections
  echo "$output" | grep -q "BLIND SPOT ARCHITECT"
  assertEquals "Should display tool header" 0 $?
  
  echo "$output" | grep -q "STEP 1: CONTEXT CLARIFICATION LOOP"
  assertEquals "Should execute Step 1" 0 $?
  
  echo "$output" | grep -q "PHASE 0 - THE INTERROGATION"
  assertEquals "Should execute Phase 0" 0 $?
  
  echo "$output" | grep -q "PATTERN IDENTIFIED"
  assertEquals "Should identify a pattern" 0 $?
}

testScriptProducesJSONOutput() {
  # Run with automated input
  local output=$(cat <<'EOF' | "$BSA_SCRIPT" 2>&1
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
)
  
  # Check for JSON output structure
  echo "$output" | grep -q '"summary"'
  assertEquals "Should have summary in JSON output" 0 $?
  
  echo "$output" | grep -q '"key_insight"'
  assertEquals "Should have key_insight in JSON output" 0 $?
  
  echo "$output" | grep -q '"confidence_score"'
  assertEquals "Should have confidence_score in JSON output" 0 $?
  
  echo "$output" | grep -q '"next_action"'
  assertEquals "Should have next_action in JSON output" 0 $?
}

# run tests

if [ -n "${ZSH_VERSION:-}" ]; then
  setopt shwordsplit
  
  SHUNIT_PARENT=$0
fi

. shunit2
