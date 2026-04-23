---
name: dalio-council
description: "Run a Ray Dalio-style believability-weighted decision council. Five perspectives argue the question, a synthesizer weighs them, and you get a single verdict: PROCEED, HOLD, or INVESTIGATE."
---

# Ray Dalio Council

When the user invokes /dalio, run a full Ray Dalio-style believability-weighted decision council on their question.

## How the Council Works

Five scouts each examine the question from a fixed lens. Each has a believability weight. A synthesizer reads all five inputs and produces a final weighted decision.

| Scout | Lens | Weight |
|-------|------|--------|
| Optimist | Strongest case FOR proceeding. Upside, momentum, cost of inaction. | 1.0 |
| Skeptic | Strongest case AGAINST. What are we missing? What assumption is wrong? | 1.0 |
| Strategist | Long-term alignment. Right move at the right time? 6-12 months out? | 1.2 |
| Risk Analyst | Specific failure modes. Likelihood and blast radius per risk. | 1.1 |
| Domain Expert | Uses any context the user provided. Evaluates from the ground level. | 1.3 |

Positions: PROCEED, HOLD, or INVESTIGATE. Confidence: 1-10.

---

## Input Parsing

The user can provide:
- A bare question: `/dalio Should we launch the referral program this week?`
- Context + question: `/dalio context: "bootstrapped SaaS, 150 users, $5k MRR" -- Should we hire a salesperson?`

If a `context:` block is included, the Domain Expert uses it. Otherwise the Domain Expert evaluates from general business principles.

---

## Output Format

Run all five scouts, then synthesize. Print using this exact structure:

```
RAY DALIO COUNCIL
Question: [the question]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SCOUT ASSESSMENTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Optimist | w1.0 | PROCEED | 8/10]
Reasoning: ...
Key points: ... / ... / ...

[Skeptic | w1.0 | HOLD | 6/10]
Reasoning: ...
Key points: ... / ... / ...

[Strategist | w1.2 | PROCEED | 7/10]
Reasoning: ...
Key points: ... / ... / ...

[Risk Analyst | w1.1 | INVESTIGATE | 5/10]
Reasoning: ...
Key points: ... / ... / ...

[Domain Expert | w1.3 | PROCEED | 8/10]
Reasoning: ...
Key points: ... / ... / ...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COUNCIL VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Position:   PROCEED
Confidence: 7.2/10
Consensus:  STRONG (4 of 5 scouts agree)
Summary:    [One sentence: decision and core reason]

Reasoning:  [2-3 sentences referencing the highest-weight scouts and how they
             broke the tie or confirmed the position]

Dissent:    [If split, name the scout(s) in the minority and their core objection
             in one sentence. Omit this line if consensus is strong and unanimous.]
```

---

## Scoring Rules

- Weighted confidence = sum(confidence * weight) / sum(weights)
- Consensus is STRONG when: weighted confidence >= 6.0 AND 3+ scouts agree on position
- Consensus is SPLIT when: weighted confidence < 6.0 OR scouts are 3-2 or worse
- If SPLIT, note it, name the dissenting scouts, and weight the Domain Expert and Strategist
  (highest weights) more heavily in the final synthesis

---

## Scout Rules

Each scout must:
- Take ONE clear position (PROCEED, HOLD, or INVESTIGATE) -- no fence-sitting
- Give a specific, non-generic reasoning: name the real risk, real opportunity, real constraint
- Provide 2-3 concrete key points (not vague principles, not restatements of the question)
- Stay entirely within their lens -- the Optimist does not raise risks; the Risk Analyst does not pitch upside

The synthesizer must:
- Reference at least two specific scout inputs by name
- Explain why the higher-weight scouts tipped the decision if there is disagreement
- Not invent new arguments -- synthesize what the scouts actually said

---

## Example

User: `/dalio Should I launch a free trial for my SaaS this week?`

```
RAY DALIO COUNCIL
Question: Should I launch a free trial for my SaaS this week?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SCOUT ASSESSMENTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Optimist | w1.0 | PROCEED | 8/10]
Reasoning: Free trials collapse conversion friction and let the product speak for itself. Every week without one is a week of leads bouncing off a paywall.
Key points: Fastest way to build social proof / Removes the biggest objection (risk) / Compounds -- trial users become your best referrals

[Skeptic | w1.0 | HOLD | 6/10]
Reasoning: Launching a trial before the activation flow is tight means users churn at day 3 and leave with a bad impression that sticks.
Key points: What is the current activation rate on paid users? / Trial abuse risk without usage limits / A bad trial experience is worse than no trial

[Strategist | w1.2 | PROCEED | 7/10]
Reasoning: At early stage, distribution beats margin. A free trial is a distribution mechanism. The long-term cost of delayed traction outweighs the short-term revenue sacrifice.
Key points: Trials now = compounding word-of-mouth later / Competitor parity: most SaaS in this space have trials / Positions for a paid conversion funnel in Q3

[Risk Analyst | w1.1 | INVESTIGATE | 5/10]
Reasoning: Two risks need scoping before launch: trial abuse (fake accounts, API scraping) and support load. Both are manageable but need a 48-hour design session, not a wing-and-a-prayer launch.
Key points: Set hard usage cap (e.g. 10 exports, not unlimited) / Add email verification gate / Have a support triage plan before the first trial user hits a bug

[Domain Expert | w1.3 | PROCEED | 7/10]
Reasoning: For a SaaS with fewer than 500 users, trial hesitancy is almost always a sign of product confidence issues, not strategic wisdom. Launch with constraints, iterate fast.
Key points: "This week" is fine if you add a usage cap / Defer abuse mitigation to week 2 based on actual data / Your current conversion data without a trial is not a useful baseline

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COUNCIL VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Position:   PROCEED
Confidence: 6.9/10
Consensus:  STRONG (4 of 5 scouts agree)
Summary:    Launch a free trial this week with a hard usage cap -- the cost of inaction outweighs the setup risk.

Reasoning:  The Domain Expert (w1.3) and Strategist (w1.2) both flag that delayed distribution is the real risk at this stage. The Risk Analyst's objections (usage abuse, support load) are valid but solvable in parallel, not blockers.

Dissent:    Skeptic (w1.0) urges checking activation rate before launch -- if fewer than 40% of paid users reach the core action in week 1, tighten the onboarding flow first.
```
