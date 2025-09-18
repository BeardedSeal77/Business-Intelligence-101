# Mining Frequent Patterns, Associations & Correlations – Day 4 Study Guide  

===================================================================================================================================

## 1. What is Association-to-Correlation Analysis?  

**Definition**: While support and confidence are the basic measures for association rules, they are sometimes insufficient because they can report misleading or uninteresting rules.  

- Example: A rule with high confidence may occur simply because the consequent item is very frequent, not because there is a meaningful association.  
- **Solution**: Introduce **correlation measures** to evaluate the real strength of the relationship between items.  

===================================================================================================================================

## 2. What is a Correlation Measure?  

**Definition**: A correlation measure quantifies whether the occurrence of one itemset is statistically dependent on another.  

### 2.1 Lift  
- **Definition**: A simple correlation measure that compares observed co-occurrence with what would be expected if the items were independent.  
- **Formula**:  

Lift(A → B) = P(A ∪ B) / (P(A) × P(B)) = P(B|A) / P(B) = Confidence(A → B) / Support(B)  

- **Interpretation**:  
  - Lift > 1 → Positive correlation (items occur together more often than expected).  
  - Lift = 1 → Independence (no correlation).  
  - Lift < 1 → Negative correlation (items co-occur less often than expected).  

**Example**:  
- A = sale of computer games, B = sale of videos.  
- If Lift = 1.2, then buying games increases chance of buying videos by 20%.  
- If Lift = 0.89 (as in the PDF example), then buying games decreases chance of buying videos (negative correlation).  

===================================================================================================================================

### 2.2 Chi-Square (χ²) Test  
- **Definition**: A statistical test that examines whether two events (A and B) are independent.  
- **Method**:  
  - Build a **contingency table** of observed vs expected values.  
  - Calculate χ² = Σ (Observed – Expected)² / Expected.  
  - Large χ² value → reject independence → A and B are correlated.  

**Example**:  
- Survey of 1,500 people: gender vs reading preference.  
- Expected values computed from overall distributions.  
- If χ² > threshold at given significance level, reject independence.  

===================================================================================================================================

### 2.3 All-Confidence  
- **Definition**: For an itemset X = {i1, i2, …, ik}, the all-confidence is defined as:  

AllConfidence(X) = Support(X) / max(Support(i1), Support(i2), …, Support(ik))  

- **Interpretation**: Ensures that the joint occurrence of items is strong relative to their individual supports.  

===================================================================================================================================


## 3. What is Constraint-Based Association Mining?  

**Definition**: A method that integrates user-specified constraints into the mining process to reduce the search space and ensure the discovered rules are useful.  

- Motivation: Without constraints, mining may generate thousands of irrelevant rules.  

### Types of Constraints  

1. **Knowledge Type Constraints** – Specify type of knowledge (e.g., association, correlation).  
2. **Data Constraints** – Specify relevant dataset or attributes.  
3. **Dimension/Level Constraints** – Restrict mining to certain dimensions or concept hierarchy levels.  
4. **Interestingness Constraints** – Apply thresholds on support, confidence, correlation.  
5. **Rule Constraints** – Specify the form of rules (e.g., only rules of the form Gender → Reading Preference).  

===================================================================================================================================

## 4. What is Metarule-Guided Mining?  

**Definition**: A technique where users specify a general rule form (metarule) to guide the mining process.  

- **Purpose**: Allows users to focus on hypotheses they are interested in testing.  
- **Benefit**: Improves efficiency and directs discovery to meaningful rules.  

**Example**:  
- Metarule: *Customer Demographic → Product Category*.  
- System will generate only rules that match this structure, ignoring unrelated associations.  

===================================================================================================================================

# Detailed Terminology List  

- **Support** – Frequency of occurrence of an itemset.  
- **Confidence** – Strength of an association rule.  
- **Correlation Measure** – Determines statistical dependence between items.  
- **Lift** – Ratio showing how much more often two items occur together compared to independence.  
- **Positive Correlation** – Items appear together more often than expected (Lift > 1).  
- **Negative Correlation** – Items appear together less often than expected (Lift < 1).  
- **Chi-Square (χ²)** – Statistical test of independence for categorical variables.  
- **All-Confidence** – Ratio of support of itemset to maximum support of individual items.  
- **Constraint-Based Mining** – Applying user-defined conditions to filter rules.  
- **Knowledge Type Constraint** – Defines the type of patterns to mine.  
- **Data Constraint** – Restricts which data is mined.  
- **Dimension/Level Constraint** – Limits rules to certain attribute levels.  
- **Interestingness Constraint** – Sets thresholds (support, confidence, lift).  
- **Rule Constraint** – Controls the structure of generated rules.  
- **Metarule** – A template or form of rule that guides mining.  
- **Metarule-Guided Mining** – Mining constrained by predefined rule structures.  

===================================================================================================================================
