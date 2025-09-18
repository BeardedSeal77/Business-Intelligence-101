Week 2 Study Materials - Difficulty Analysis & Review Focus

  High-Priority Mathematical Concepts (Require Practice)

  1. Association Rule Calculations (Days 2-4)

  - Support formula: Count(A∩B) / Total Transactions
  - Confidence formula: Support(A∪B) / Support(A)
  - Lift calculation: P(A∪B) / (P(A) × P(B))
  - Chi-Square test: χ² = Σ(Observed - Expected)² / Expected
  - Practice with concrete examples from market basket datasets

  2. Algorithm Complexity (Day 3)

  - Apriori: Level-wise candidate generation, exponential growth issues
  - FP-Growth: Tree construction, conditional pattern mining
  - Performance trade-offs: When to use which algorithm

  Critical Conceptual Areas

  3. Data Mining Process Understanding (Day 1)

  - KDD vs Data Mining distinction
  - Six core functionalities and their applications
  - Interestingness measures beyond support/confidence

  4. R Programming Challenges (Day 2)

  - Factor manipulation: cut(), ordered(), level management
  - Missing value propagation: NA vs NaN vs Inf handling
  - Logical indexing and vectorized operations
  - String pattern matching with regex

  Areas Requiring Memorization

  5. Algorithm Properties

  - Apriori property: All subsets of frequent itemset must be frequent
  - Antimonotone property: Critical for pruning strategies
  - FP-tree construction steps and conditional pattern bases

  6. Correlation Measures

  - Lift interpretation: >1 (positive), =1 (independent), <1 (negative)
  - All-confidence formula: Support(X) / max(individual supports)
  - Constraint types in association mining

  Study Recommendations

  Practice Problems Needed:
  1. Hand-calculate support/confidence from transaction tables
  2. Work through Apriori algorithm step-by-step with small datasets
  3. R exercises with factor creation and missing value handling
  4. Pattern matching and string manipulation in R

  Review Priority Order:
  1. Association rule calculations (most exam-likely)
  2. Apriori algorithm mechanics
  3. R data structure manipulation
  4. Correlation measures and interpretation

  Weak Spots to Focus On:
  - Chi-square test application for independence
  - FP-Growth conditional mining process
  - Complex R factor operations with cut() and level management
  - Distinguishing when lift indicates meaningful correlation