# Blind Spot Architect

**The Mirror of Brutal Truth**

## Overview

The Blind Spot Architect is a confrontational documentation validation tool designed to expose the gap between intent and reality in your dotfiles repository. Unlike traditional linters or documentation checkers, this tool uses psychological interrogation techniques to identify *why* documentation gaps exist and force concrete action to fix them.

## Purpose

- **Expose self-deception** about documentation quality
- **Calculate the real cost** of poor documentation
- **Force immediate action** rather than perpetual planning
- **Use brutal honesty** to cut through excuses

## Features

### 1. Context Clarification Loop
Interactive questioning to establish concrete reality:
- Which config files cause friction?
- Where is documentation outdated/misleading?
- What specific validation failures exist?
- When did you last audit your README?
- What percentage of features do you actually use?

### 2. Phase 0 - The Interrogation
Psychological probing to reveal true priorities:
- The "impossible" goal you're afraid to commit to
- The "logical" excuse for not fixing documentation
- What your actual priorities are vs. stated priorities

### 3. The Analysis Protocol (4 Phases)

#### Phase 1: Pattern Recognition
Identifies behavioral patterns like:
- **The Maintainer's Martyrdom**: Too busy to document
- **The Self-Evident Delusion**: Code speaks for itself
- **The Chronic Procrastinator**: Will fix it "later"
- **The README Fiction**: Docs describe what you wish you had

#### Phase 2: Cost Calculation
Calculates tangible costs over 5 years:
- Debugging time for undocumented config
- Onboarding/explanation time
- Re-learning forgotten code
- Financial projection with hourly rates

#### Phase 3: Delusion Challenge
Uses "courtroom logic" to dismantle excuses using your own words against you.

#### Phase 4: Forced Evolution
Provides ONE binary action: Fix specific documentation within 60 minutes or admit you've given up.

## Usage

### Basic Usage

```bash
./bin/blind-spot-architect.sh
```

The script will interactively ask you questions. Answer honestly for best results.

### Automated Testing

```bash
./bin/test-blind-spot-architect.sh
```

### Expected Output

The tool produces:
1. Interactive Q&A session
2. Brutal analysis of your behavioral patterns
3. Cost calculation showing financial impact
4. Logical dismantling of your excuses
5. Final JSON output with summary and next action

### JSON Output Format

```json
{
  "summary": "Brief description of the gap identified",
  "key_insight": "Core insight about the root cause",
  "confidence_score": 0-100,
  "next_action": "Specific action to take immediately"
}
```

## Tone & Philosophy

This tool is **intentionally confrontational**. It uses:
- **Maximum brutality**: No euphemisms or softening
- **Logic over emotion**: Data-driven arguments
- **Confrontational approach**: Calls out self-deception immediately

If you want a supportive, encouraging experience, this is not the tool for you.

## When to Use

Use this tool when:
- Your documentation is out of sync with code
- You keep postponing documentation updates
- You're not sure why documentation gaps persist
- You need external pressure to prioritize documentation
- You're ready to face uncomfortable truths

## Integration with dotfiles Repository

This tool is specifically designed for the voku/dotfiles repository but can be adapted for other projects. It validates:
- README.md accuracy
- Configuration file documentation
- Alias and function documentation
- Plugin documentation
- Installation instructions

## Requirements

- Bash 4.0+
- ANSI color support (for brutal visual impact)
- Honesty (the tool is useless without it)

## Exit Codes

- `0`: Successful completion
- `1`: User rejected clarified context (needs to start over)

## Philosophy

> "The gap between documented intent and actual implementation is not a knowledge problem - it's a priority problem disguised as a time problem."

This tool forces you to:
1. Admit what the real problem is
2. Calculate what it costs you
3. Stop making excuses
4. Take immediate action

## Examples

### Example Session

```
Q: Which specific configuration files are causing friction?
A: .zshrc and .aliases files

Q: Is the documentation outdated, non-existent, or misleading?
A: The README claims all features are documented but many aliases lack explanation

Q: What specific validation failure are you experiencing?
A: Many aliases in .aliases are not mentioned in any documentation

[... more questions ...]

PATTERN IDENTIFIED: The Maintainer's Martyrdom

THE TRUTH YOU'RE AVOIDING:
You wear your 'too busy to document' badge like a medal...
[... brutal analysis ...]

5-YEAR COST: $14,250
TIME TO FIX: ~4 hours
ONE-TIME INVESTMENT: $300
5-YEAR SAVINGS: $13,950
```

## Contributing

Contributions welcome, but keep the brutal tone intact. This tool's effectiveness depends on its confrontational nature.

## License

MIT License (see parent repository)

## Credits

Part of the [voku/dotfiles](https://github.com/voku/dotfiles) project.
