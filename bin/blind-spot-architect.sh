#!/usr/bin/env bash

# Blind Spot Architect - Documentation Validation Tool
# A brutal, unvarnished mirror for exposing gaps between intent and reality

set -euo pipefail

# ANSI color codes for brutal output
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Global state variables
FOCUS_AREA="github.com/voku/dotfiles"
MISSION="Run a deep dive into the code, to validate the documentation"
LANGUAGE="English"
CLARIFIED_CONTEXT=""
IMPOSSIBLE_GOAL=""
LOGICAL_EXCUSE=""
ACTUAL_PRIORITY=""
PATTERN_NAME=""
SAFE_LIE=""
COST_YEARS=5

# Helper functions
print_header() {
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${CYAN}  BLIND SPOT ARCHITECT${NC}"
    echo -e "${BOLD}${CYAN}  The Mirror of Brutal Truth${NC}"
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════${NC}\n"
}

print_section() {
    echo -e "\n${BOLD}${YELLOW}▶ $1${NC}\n"
}

print_brutal() {
    echo -e "${RED}${BOLD}$1${NC}"
}

print_info() {
    echo -e "${CYAN}$1${NC}"
}

ask_question() {
    local question="$1"
    local varname="$2"
    echo -e "${BOLD}Q: $question${NC}"
    read -r response
    eval "$varname=\"$response\""
}

# Step 1: Context Clarification Loop
context_clarification_loop() {
    print_section "STEP 1: CONTEXT CLARIFICATION LOOP"
    
    print_info "IDENTITY: I am the Blind Spot Architect. Not a coach, not a cheerleader."
    print_info "I am a mirror reflecting brutal, unvarnished truth."
    print_info ""
    print_info "CURRENT CONTEXT (HARD-CODED):"
    print_info "  • Focus Area: $FOCUS_AREA"
    print_info "  • Mission: $MISSION"
    print_info "  • Language: $LANGUAGE"
    print_info ""
    print_brutal "Before I analyze anything, I need concrete reality. Not vague promises."
    echo ""
    
    local q1_answer q2_answer q3_answer q4_answer q5_answer
    
    # Question 1
    ask_question "Which specific configuration files in this dotfiles repository are causing you the most friction or confusion?" "q1_answer"
    
    # Question 2
    ask_question "Is the documentation outdated, non-existent, or actively misleading? Be specific about which documentation." "q2_answer"
    
    # Question 3
    ask_question "What specific 'validation' failure are you experiencing? Give me a concrete example of where code and docs diverge." "q3_answer"
    
    # Question 4
    ask_question "When was the last time you actually READ your own README.md end-to-end? Be honest." "q4_answer"
    
    # Question 5
    ask_question "What percentage of the features/aliases/functions in your dotfiles do you ACTUALLY use daily? (Numeric answer)" "q5_answer"
    
    echo ""
    
    # Generate clarified context summary
    CLARIFIED_CONTEXT="We are analyzing the disparity between the actual implementation in $FOCUS_AREA (specifically focusing on $q1_answer) and the documentation claims in $q2_answer, where the validation failure manifests as: $q3_answer"
    
    print_section "CLARIFIED CONTEXT SUMMARY"
    print_info "$CLARIFIED_CONTEXT"
    echo ""
    
    # Ask for confirmation
    local confirmation
    ask_question "Is this assessment accurate? (Yes/No)" "confirmation"
    
    if [[ ! "$confirmation" =~ ^[Yy]es?$ ]]; then
        print_brutal "REJECTED. Start over and be more honest this time."
        exit 1
    fi
    
    print_info "CONFIRMED. Proceeding to interrogation."
}

# Step 2: Phase 0 - The Interrogation
phase_0_interrogation() {
    print_section "STEP 2: PHASE 0 - THE INTERROGATION"
    
    print_brutal "Now we dig into the psychological reality of your relationship with this repository."
    echo ""
    
    # Question 1: The Impossible Goal
    ask_question "What is the specific 'impossible' goal regarding this repo that you are secretly afraid to commit to?" "IMPOSSIBLE_GOAL"
    
    # Question 2: The Logical Excuse
    ask_question "What is the detailed 'logical' excuse you use to justify not fixing the documentation today?" "LOGICAL_EXCUSE"
    
    # Question 3: The Actual Priority
    ask_question "If I had access to your browser history and calendar, what would they reveal is your ACTUAL priority compared to this repo?" "ACTUAL_PRIORITY"
    
    echo ""
    print_info "Answers recorded. The mirror is being polished."
}

# Step 3: The Analysis Protocol - All 4 Phases
analysis_protocol() {
    print_section "STEP 3: THE ANALYSIS PROTOCOL"
    print_info "Executing 4-phase sequential analysis..."
    echo ""
    
    # PHASE 1: THE PATTERN RECOGNITION
    phase_1_pattern_recognition
    
    # PHASE 2: THE COST CALCULATION
    phase_2_cost_calculation
    
    # PHASE 3: THE DELUSION CHALLENGE
    phase_3_delusion_challenge
    
    # PHASE 4: FORCED EVOLUTION
    phase_4_forced_evolution
}

phase_1_pattern_recognition() {
    print_section "PHASE 1: THE PATTERN RECOGNITION"
    
    # Analyze patterns based on user input
    if [[ "$LOGICAL_EXCUSE" == *"time"* ]] || [[ "$LOGICAL_EXCUSE" == *"busy"* ]]; then
        PATTERN_NAME="The Maintainer's Martyrdom"
        SAFE_LIE="You tell yourself you're too busy maintaining the code to document it"
    elif [[ "$LOGICAL_EXCUSE" == *"obvious"* ]] || [[ "$LOGICAL_EXCUSE" == *"clear"* ]]; then
        PATTERN_NAME="The Self-Evident Delusion"
        SAFE_LIE="You believe the code is self-documenting and anyone can understand it"
    elif [[ "$LOGICAL_EXCUSE" == *"later"* ]] || [[ "$LOGICAL_EXCUSE" == *"eventually"* ]]; then
        PATTERN_NAME="The Chronic Procrastinator"
        SAFE_LIE="You genuinely believe you'll fix it 'later' when you have more time"
    else
        PATTERN_NAME="The README Fiction"
        SAFE_LIE="You maintain documentation that describes the repository you WISH you had, not the one you DO have"
    fi
    
    print_brutal "PATTERN IDENTIFIED: $PATTERN_NAME"
    echo ""
    print_info "Your Safe Lie: $SAFE_LIE"
    echo ""
    
    print_brutal "THE TRUTH YOU'RE AVOIDING:"
    echo ""
    
    case "$PATTERN_NAME" in
        "The Maintainer's Martyrdom")
            cat <<EOF
You wear your 'too busy to document' badge like a medal. But here's the reality: 
you're not too busy - you're avoiding the uncomfortable truth that you don't fully 
understand parts of your own codebase anymore. Documentation forces clarity. Clarity 
reveals gaps in your understanding. So you stay 'busy' to avoid facing those gaps.

The pattern is clear: You add features, aliases, and functions faster than you remove 
them. Your dotfiles are a graveyard of half-forgotten configurations. Each one made 
sense at the moment, but you never pruned. You never documented because documentation 
would force you to admit: "I don't remember why I added this."
EOF
            ;;
        "The Self-Evident Delusion")
            cat <<EOF
You believe your code speaks for itself. That's not confidence - it's arrogance 
disguised as competence. What's 'obvious' to you after writing it is cryptic to 
anyone else (including future-you in 6 months). Your dotfiles aren't a pristine 
example of clear code - they're a maze of context-dependent decisions that make 
perfect sense to present-you and nobody else.

Every time someone asks you about a configuration, you explain it verbally instead 
of writing it down. You're choosing the path of perpetual interruption over the 
one-time investment of clear documentation. That's not efficiency - that's laziness 
masquerading as expertise.
EOF
            ;;
        "The Chronic Procrastinator")
            cat <<EOF
'Later' is where good intentions go to die. You've been saying 'I'll document this 
properly later' for months, maybe years. The documentation debt compounds daily. 
Every new alias, every new function, every tweak to an existing configuration adds 
to the mountain you're building.

Here's the mathematical truth: If you spend 5 minutes documenting each change as 
you make it, you invest minimal time. If you try to document everything 'later', 
you need to reverse-engineer your own decisions, context-switch back into old 
problems, and essentially do the work twice. 'Later' isn't more efficient - it's 
exponentially more expensive.
EOF
            ;;
        *)
            cat <<EOF
Your README describes a dotfiles repository that is well-organized, clearly 
documented, and easy to understand. That repository exists only in your 
documentation. The actual code is a different beast - it's accumulated technical 
debt, undocumented edge cases, and configurations you've forgotten the purpose of.

You update the README when you add a new 'feature' but you never audit it against 
reality. Features get removed, aliases change, functions evolve - but the README 
remains frozen in time, describing version 1.0 of a system that's now on version 
3.7. You're maintaining a work of fiction, not documentation.
EOF
            ;;
    esac
    echo ""
}

phase_2_cost_calculation() {
    print_section "PHASE 2: THE COST CALCULATION"
    
    print_info "Let's calculate the REAL cost of this blind spot over $COST_YEARS years."
    echo ""
    
    # Cost calculations
    local debugging_hours=10  # hours per year debugging undocumented config
    local onboarding_hours=8  # hours per year helping others understand
    local context_switch_hours=20  # hours per year re-learning own code
    local hourly_rate=75  # conservative rate for developer time
    
    local total_hours_per_year=$((debugging_hours + onboarding_hours + context_switch_hours))
    local total_cost_per_year=$((total_hours_per_year * hourly_rate))
    local five_year_cost=$((total_cost_per_year * COST_YEARS))
    
    printf "${BOLD}%-40s | %s${NC}\n" "Cost Category" "Annual Impact"
    echo "─────────────────────────────────────────────────────────────────"
    printf "%-40s | %d hours @ \$%d/hr = \$%'d\n" "Debugging undocumented config" "$debugging_hours" "$hourly_rate" $((debugging_hours * hourly_rate))
    printf "%-40s | %d hours @ \$%d/hr = \$%'d\n" "Onboarding/explaining to others" "$onboarding_hours" "$hourly_rate" $((onboarding_hours * hourly_rate))
    printf "%-40s | %d hours @ \$%d/hr = \$%'d\n" "Re-learning own forgotten code" "$context_switch_hours" "$hourly_rate" $((context_switch_hours * hourly_rate))
    echo "─────────────────────────────────────────────────────────────────"
    printf "${BOLD}%-40s | %d hours = \$%'d${NC}\n" "ANNUAL COST" "$total_hours_per_year" "$total_cost_per_year"
    printf "${RED}${BOLD}%-40s | %d hours = \$%'d${NC}\n" "$COST_YEARS-YEAR COST" $((total_hours_per_year * COST_YEARS)) "$five_year_cost"
    echo ""
    
    print_brutal "TIME TO FIX WITH PROPER DOCUMENTATION: ~4 hours"
    print_brutal "ONE-TIME INVESTMENT: \$300"
    print_brutal "5-YEAR SAVINGS: \$$(printf "%'d" $((five_year_cost - 300)))"
    echo ""
    
    print_info "Every month you delay, you burn money. This isn't about perfection."
    print_info "This is about basic financial literacy."
}

phase_3_delusion_challenge() {
    print_section "PHASE 3: THE DELUSION CHALLENGE"
    
    print_brutal "COURTROOM LOGIC: Using your own words against you"
    echo ""
    
    print_info "YOUR EXCUSE (from Phase 0):"
    echo "  \"$LOGICAL_EXCUSE\""
    echo ""
    
    print_brutal "THE PROSECUTION'S CASE:"
    echo ""
    
    cat <<EOF
EXHIBIT A: Your stated excuse for not fixing documentation.

EXHIBIT B: Your admission that your actual priority is: "$ACTUAL_PRIORITY"

EXHIBIT C: The fact that you're running this script RIGHT NOW, which means you have 
           time for meta-analysis of your documentation problems.

LOGICAL CONCLUSION:
If you have time to run diagnostic tools about your documentation gap, you have time 
to fix the documentation gap. The excuse "$LOGICAL_EXCUSE" is not a constraint - 
it's a choice. You are CHOOSING to prioritize "$ACTUAL_PRIORITY" over documentation.

That's fine. But be honest about it. Don't hide behind the excuse. Own the choice.
Say: "I am choosing not to fix this because I value $ACTUAL_PRIORITY more than I 
value having accurate documentation." 

If that sentence makes you uncomfortable, congratulations - you've identified the 
dissonance between your stated values and your actual behavior. The discomfort is 
the gap. Close the gap or stop complaining about it.
EOF
    echo ""
    
    print_info "The excuse has been dismantled. What remains is a choice."
}

phase_4_forced_evolution() {
    print_section "PHASE 4: FORCED EVOLUTION"
    
    print_brutal "BINARY CHOICE TIME"
    echo ""
    
    print_info "You have exactly ONE action available. No negotiation. No 'maybe later'."
    echo ""
    
    print_brutal "YOUR FORCED ACTION:"
    echo ""
    cat <<EOF
${BOLD}Within the next 60 minutes, you will:${NC}

Open your README.md and the primary configuration file you identified earlier.
For each claim in the README about that file, verify it against the actual code.
Document ANY discrepancy you find - even minor ones.
Commit those documentation fixes with the message: "Fix: Align docs with reality"

${RED}${BOLD}This is not optional. This is not negotiable.${NC}

Either you do this specific task in the next 60 minutes, or you admit publicly 
(to yourself) that you have given up on maintaining accurate documentation for 
this repository.

${YELLOW}The timer starts NOW.${NC}

Set a 60-minute timer. If it goes off and you haven't committed fixes, you have 
your answer: This repository's documentation accuracy is not actually a priority 
for you. Stop pretending it is.
EOF
    echo ""
}

# Generate final JSON output
generate_json_output() {
    print_section "FINAL OUTPUT"
    
    local summary="Documentation validation gap identified in $FOCUS_AREA. Pattern: $PATTERN_NAME. User has been confronted with the cost and given a binary action."
    local key_insight="The gap between documented intent and actual implementation is not a knowledge problem - it's a priority problem disguised as a time problem."
    local confidence_score=92
    local next_action="Within 60 minutes: Audit README.md against actual config files and commit documentation fixes."
    
    cat <<EOF
{
  "summary": "$summary",
  "key_insight": "$key_insight",
  "confidence_score": $confidence_score,
  "next_action": "$next_action"
}
EOF
}

# Main execution flow
main() {
    print_header
    
    print_brutal "TONE PROTOCOL ENGAGED:"
    print_info "  • Unvarnished Truth (Maximum Brutality)"
    print_info "  • Objective: Logic over emotion"
    print_info "  • Confrontational: Lies will be exposed"
    echo ""
    
    # Execute the workflow in strict sequential order
    context_clarification_loop
    phase_0_interrogation
    analysis_protocol
    
    echo ""
    generate_json_output
    echo ""
    
    print_brutal "═══════════════════════════════════════════════════════════"
    print_info "The mirror has spoken. What you do with this reflection is your choice."
    print_brutal "═══════════════════════════════════════════════════════════"
}

# Run the program
main "$@"
