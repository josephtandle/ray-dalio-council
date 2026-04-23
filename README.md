# Ray Dalio Council

A Claude Code skill that runs a Ray Dalio-style believability-weighted decision council on any question.

Five specialist scouts each argue the question from a different angle. A synthesizer weighs them by believability and returns a single verdict: **PROCEED**, **HOLD**, or **INVESTIGATE** with a confidence score.

Inspired by Ray Dalio's decision-making system at Bridgewater Associates.

---

## Install

```bash
mkdir -p ~/.claude/skills && curl -fsSL https://raw.githubusercontent.com/josephtandle/ray-dalio-council/main/dalio-council.md -o ~/.claude/skills/dalio-council.md
```

One command. Downloads the skill file directly. No repo cloning, no cleanup.

---

## Usage

In any Claude Code session:

```
/dalio Should we launch the referral program this week?
```

With context:

```
/dalio context: "bootstrapped SaaS, 200 users, $8k MRR" -- Should we hire a full-time salesperson?
```

---

## How It Works

Five scouts examine your question from fixed lenses, each with a believability weight:

| Scout | Lens | Weight |
|-------|------|--------|
| Optimist | Strongest case FOR proceeding | 1.0 |
| Skeptic | Strongest case AGAINST. What are we missing? | 1.0 |
| Strategist | Long-term alignment. Right move at the right time? | 1.2 |
| Risk Analyst | Specific failure modes. Likelihood and blast radius. | 1.1 |
| Domain Expert | Evaluates from your context, or general business principles | 1.3 |

The synthesizer weighs their inputs and returns:

- **Position** -- PROCEED, HOLD, or INVESTIGATE
- **Confidence** -- 1-10 weighted average
- **Consensus** -- STRONG (4+ agree) or SPLIT
- **Summary** -- one actionable sentence
- **Dissent** -- the minority view if the vote was split

---

## Example Output

```
RAY DALIO COUNCIL
Question: Should I launch a free trial for my SaaS this week?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SCOUT ASSESSMENTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Optimist | w1.0 | PROCEED | 8/10]
[Skeptic | w1.0 | HOLD | 6/10]
[Strategist | w1.2 | PROCEED | 7/10]
[Risk Analyst | w1.1 | INVESTIGATE | 5/10]
[Domain Expert | w1.3 | PROCEED | 7/10]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COUNCIL VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Position:   PROCEED
Confidence: 6.9/10
Consensus:  STRONG (4 of 5 scouts agree)
Summary:    Launch a free trial this week with a hard usage cap.
```

---

## Requirements

- Claude Code (any version)
- No API keys, no dependencies, no configuration

---

## Free from the Business Automation Mastermind

This skill was built by [Joe Che](https://www.mastermindshq.business) at the Business Automation Mastermind -- a community for SMB owners who build AI into how their business runs.

More free tools: [workshop.mastermindshq.business/giveaways](https://workshop.mastermindshq.business/giveaways)
