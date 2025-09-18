# Rule-Based Classification — Full Study Notes

These notes explain the whole slide deck in plain, study-friendly language with examples, formulas, and quick checks so you can revise confidently.

---

## 1) What is a rule-based classifier?

* A **rule-based classifier** predicts a class label using a set of **IF–THEN rules**.
* Each rule has:

  * **Antecedent / precondition** (the IF part): one or more **attribute tests** combined with logical AND.
  * **Consequent** (the THEN part): a **class prediction**.
    Example: **R1:** IF `age = youth` AND `student = yes` THEN `buys_computer = yes`.

**Key terms**

* A rule **covers** a tuple if the tuple satisfies the antecedent.
* A rule **triggers** for a tuple when its antecedent is satisfied; it **fires** if it’s the rule chosen to make the final prediction.

---

## 2) Rule quality: coverage & accuracy

Given labeled dataset **D**, for a rule **R**:

* `n_covers` = number of tuples in **D** covered by **R**
* `n_correct` = number of covered tuples that **R** classifies correctly

Then:

* **Coverage** = `n_covers / |D|`
* **Accuracy** = `n_correct / n_covers` (measured over covered tuples)
  Example (AllElectronics): If **R1** covers 2 of 14 tuples and gets both right → coverage = 2/14, accuracy = 2/2.

---

## 3) When multiple rules trigger (conflict resolution)

Sometimes more than one rule is satisfied for the same tuple. To decide which one **fires**, common strategies are:

### A) **Size ordering**

* Prefer the rule with the **largest antecedent** (most tests) → the “toughest” / most **specific** rule wins.
* Idea: more conditions → more specific → less chance of accidental match.

### B) **Rule ordering (decision list)**

* Pre-order rules and apply **top-down**; the first satisfied rule fires.
* Two ways to order:

  * **Class-based ordering**: put rules for “more important” classes first (by prevalence or **misclassification cost**).
  * **Rule-based ordering**: sort rules by a quality measure (e.g., accuracy, coverage, size) or expert advice.
* Notes: With ordering, rules form a **decision list**; interpretation is harder because each rule implicitly negates prior ones.

### C) **Default rule**

* If **no** rule is satisfied, fall back to a **default** (typically **majority** class overall or among uncovered tuples). The default has an **empty** condition and is tried **last**.

---

## 4) Getting rules from decision trees

* **One rule per root-to-leaf path**. AND all split tests along the path to form the antecedent; the **leaf class** is the consequent.
* The set of rules extracted from a tree is **mutually exclusive and exhaustive** (no conflicts).
* **Rule pruning** (post-extraction): remove any antecedent test that **doesn’t improve** estimated rule accuracy. After pruning, rules may no longer be mutually exclusive/exhaustive, so conflict handling is needed.

---

## 5) Learning rules **directly** from data: Sequential covering

* Learn rules **one at a time** for a target class **C**, each time **removing** the positives that the new rule covers; repeat until **stopping condition** met (e.g., too few positives left, or quality below threshold).

**High-level procedure**

1. Choose a target class **C** (positives = class **C**, negatives = others).
2. **LearnOneRule**: start with an **empty** antecedent (most general rule), then **grow** it (general-to-specific) by greedily appending the attribute test that best **improves rule quality**.
3. Stop growing when the rule reaches **acceptable quality** (or adding any test no longer improves quality).
4. **Remove** covered positives; repeat steps 2–3 until termination.

**Search details**

* **Greedy depth-first**: append the single best test at each step; no backtracking.
* **Beam search** (width **k**) can retain top-k candidates each step to reduce the chance of bad local choices.

**Illustration idea** (loan approval):

* Start: IF ( ) THEN `loan=accept`
* Best test → `income=high`; next best → `credit_rating=excellent`
* Grow until the rule is accurate enough; then remove covered positives and repeat.

---

## 6) How do we **measure** rule quality?

Accuracy alone is often misleading (a trivially specific rule can get 100% on 2 cases). Combine **how correct** and **how many** it covers. Common measures:

### A) **Accuracy & Coverage**

* Use both together when ranking rules; avoid over-valuing tiny high-accuracy rules.

### B) **Entropy / Information Gain** (as in trees)

* For candidate condition `cond'`, compute **entropy** over tuples it covers; **lower** entropy is better (more “pure”).
* **Information gain** prefers conditions that result in a **large**, **pure** covered set.

### C) **FOIL-Gain** (First-Order Inductive Learner, adapts to propositional case)

* Let **pos**, **neg** be # of positive/negative tuples covered by current rule `R`.
* Let **pos'**, **neg'** be # covered after adding a candidate test (rule `R'`).
* **FOIL-Gain** rewards increases in precision *and* enough positives covered.
  *(Exact algebraic form in slides; intuitively: bigger gain when we add a test that sharply raises the positive fraction while still covering many positives.)*

### D) **Statistical significance** (likelihood-ratio / chi-square)

* Compare observed class counts among tuples covered by the rule vs. expected counts under **random guessing**.
* A larger **likelihood-ratio statistic** (χ² with *m−1* d.f.) suggests the rule’s performance is **not due to chance**, and helps filter rules with **insignificant coverage**.

---

## 7) Avoiding overfitting: Rule pruning

* Because quality is often evaluated on the **training set**, learned rules can **overfit**.
* **Pruning** removes antecedent tests (conjuncts) if a **pruned** rule scores **better** on an **independent pruning set** (or via pessimistic estimates).
* **FOIL-Prune** (simple heuristic): compute a pruning score (involving **pos** and **neg** covered by the rule); if pruning raises the score, **prune**, and keep pruning while it still improves.

---

## 8) Putting it together — how a rule-based classifier is used

1. **Train/build rules** (from a decision tree or via sequential covering).
2. **Order rules** (if using a decision list) or choose a **conflict strategy** (size ordering, class-based ordering).
3. Add a **default rule** for uncovered cases.
4. **Classify** a new tuple **X**:

   * Find all rules whose antecedents **match** X (they **trigger**).
   * Apply conflict resolution; the selected rule **fires** and outputs its class. If none match, use **default**.

---

## 9) Worked micro-example (conflict resolution)

Rules:

* **R1**: IF `Age = youth` AND `Student = yes` THEN `Buys = yes` (size = 2)
* **R2**: IF `Income = high` THEN `Buys = no` (size = 1)

Tuple **X**: `Age=youth`, `Student=yes`, `Income=high`.

* **Size ordering** → pick **R1** (more specific) → predict **yes**.
* **Class-based ordering** (if **no** class is more prevalent/important) → if **no** is ranked higher (e.g., by prevalence or cost), pick **R2** → **no**.
* **Cost-sensitive** ordering (if misclassifying **yes** is costlier) → prefer **R1** to avoid the high-cost mistake.
* If none match → fall back to **default** class (e.g., global majority).

---

## 10) Strengths & caveats

**Pros**

* Expressive, human-readable rules; easy to **explain** decisions.
* Flexibility in conflict handling and **cost-sensitive** classification.
* Can be derived from trees **or** learned directly.

**Cons / gotchas**

* **Overfitting** without proper pruning.
* **Greedy** search can miss better global rule sets; beam search helps.
* Rule ordering (decision lists) can be **harder to interpret**; each rule implicitly negates earlier ones.

---

## 11) Exam-style checkpoints

**Explain**

* Difference between **triggering** vs **firing**.
* Why a default rule is necessary.
* Why accuracy **alone** is a bad selector for rules.

**Compute**

* Given a confusion of covered tuples, compute **coverage** and **accuracy**.
* Show how **size ordering** vs **class-based ordering** would classify the same tuple differently.

**Design**

* Sketch a **sequential covering** loop for a binary class.
* Show how you’d **prune** a too-specific rule using a pruning set or FOIL-Prune.

---

## 12) Minimal pseudo-code you can memorize

**Sequential covering (for class C):**

```r
Rules = []
Pos = {tuples with class C}
Neg = {tuples not C}
while stopping_condition_not_met(Pos):
    R = empty_antecedent  // IF ( ) THEN class = C
    Candidates = {R}
    repeat:
        best = argmax_{append one test to R} quality(R')
        if quality(best) > quality(R) + epsilon:
            R = best
        else:
            break
    R = prune(R)           // e.g., FOIL-Prune
    Rules.append(R)
    Pos = Pos - covered_positives(R)
return Rules + default_rule
```

Use **size ordering** or **decision list** at prediction time.

---

## 13) Quick “why this matters” map

* **Interpretability**: auditors, domain experts, business users can **read** rules.
* **Deployment**: rules can be embedded into SQL, triggers, or application logic.
* **Costs & prevalence**: rule ordering lets you encode **business priorities** (e.g., avoid missing high-value positives).

---

## 14) 10 fast practice prompts

1. Define **coverage** and **accuracy**; compute both for a tiny dataset.
2. Give a case where two rules trigger; resolve via **size ordering**.
3. Give the **default rule** you would pick if the global majority class is “No”.
4. Extract rules from a 3-level decision tree (one per leaf).
5. Why can pruning break “mutually exclusive & exhaustive”? What do you add to compensate?
6. Describe **FOIL-Gain** intuitively (trade-off of purity & positives covered).
7. When would you prefer **class-based ordering** over size ordering?
8. Explain how a **beam search** improves over greedy search.
9. How can **misclassification costs** change your final prediction?
10. What simple test would you use to filter rules with chance-level performance? (χ² / likelihood ratio).

---
