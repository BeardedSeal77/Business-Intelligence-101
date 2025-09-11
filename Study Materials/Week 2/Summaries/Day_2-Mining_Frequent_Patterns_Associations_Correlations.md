# Mining Frequent Patterns, Associations & Correlations – Complete Study Guide  

===================================================================================================================================


## 1. Models in Data Mining  

### What is a Model?  
- A **model** is a high-level, global description of a dataset, giving a big-picture perspective.  
- It can be:  
  1. **Descriptive** – Summarizes the data concisely (e.g., profiles, averages, groupings).  
  2. **Inferential/ Predictive** – Makes statements about the population or predicts future values.  

**Contrast**:  
- **Model** = global description.  
- **Pattern** = local feature, may hold only for a subset of records or variables.  

===================================================================================================================================

## 2. Types of Data Mining Models  

- **Association** – Finds co-occurrence relationships.  
- **Attribute Importance** – Measures how important certain attributes are.  
- **Classification** – Assigns items into predefined categories.  
- **Clustering** – Groups items without predefined labels.  
- **Feature Extraction** – Reduces dimensionality, extracts essential features.  
- **Regression** – Predicts continuous values.  

===================================================================================================================================

## 3. Association Models  

- **Definition**: Association is a **descriptive mining function** that identifies **relationships** and the **probability of their co-occurrence**.  
- **Algorithm**: Apriori.  
- **Application**: Market Basket Analysis.  
  - Example: “70% of customers who buy spaghetti, wine, and sauce also buy garlic bread.”  

**Uses**:  
- Direct marketing.  
- Catalog design.  
- Business decision-making.  

===================================================================================================================================


## 4. Frequent Patterns  

- **Definition**: Patterns that occur often in datasets.  
- **Examples**:  
  - Itemset: Milk and bread frequently bought together.  
  - Sequential pattern: Buy PC → camera → memory card.  
- **Importance**: Foundation of association, correlation, and many relationships.  

===================================================================================================================================


## 5. Market Basket Analysis  

- Earliest form of frequent pattern mining.  
- Analyzes **customer buying habits**.  
- Discovers which items tend to appear together in shopping baskets.  
- Output: **association rules** between items.  

===================================================================================================================================


## 6. Association Rules  

- Each item has a Boolean variable (present or absent in a basket).  
- A basket = Boolean vector of items.  
- Patterns are expressed as **association rules**.  

**Example**:  
- *Computer → Antivirus software [Support = 2%, Confidence = 60%]*  
  - Support = 2% → 2% of all baskets had both.  
  - Confidence = 60% → 60% of computer buyers also bought antivirus software.  

### Rule Interestingness  
- Rules must satisfy **minimum support** and **minimum confidence** thresholds.  
- Users/domain experts set thresholds.  
- Rules below threshold = discarded as uninteresting.  

===================================================================================================================================


## 7. Process of Association Rule Mining  

1. **Find all frequent itemsets** – Itemsets that occur at least as often as minimum support (min_sup).  
2. **Generate strong association rules** – Rules that satisfy both min_sup and min_conf (confidence threshold).  
3. Optionally apply **other interestingness measures** for correlations.  

===================================================================================================================================


## 8. Challenges in Association Mining  

- **Explosion of itemsets**:  
  - A huge number of itemsets can satisfy min_sup when the threshold is low.  
- **Multidimensional rules**:  
  - Example: Rules involving *age, income, and purchases*.  
  - More complex than single-dimension item associations.  

===================================================================================================================================


## 9. Apriori Algorithm  

### Overview  
- Proposed by **Agrawal & Srikant (1994)**.  
- Used for mining frequent itemsets for Boolean association rules.  
- **Key Idea**: Uses prior knowledge (Apriori property).  
- **Approach**: Level-wise iterative search.  

### Steps  
1. Find frequent 1-itemsets (**L1**) by scanning database.  
2. Use **L1** to generate **L2**, frequent 2-itemsets.  
3. Continue until no more frequent itemsets can be found.  
4. Each iteration requires a **database scan**.  

### Apriori Property  
- **All nonempty subsets of a frequent itemset must also be frequent.**  
- Antimonotone property: If an itemset is not frequent, none of its supersets can be frequent.  

### Join & Prune Steps  
1. **Join Step** – Generate candidate k-itemsets by joining sets with themselves.  
2. **Prune Step** – Remove itemsets that fail min_sup.  

===================================================================================================================================


## 10. Apriori Example  

- Suppose 9 transactions (|D|=9).  
- Minimum support = 2.  
- **Step 1**: Find candidate 1-itemsets (C1). Count support of each item.  
- **Step 2**: Generate frequent 1-itemsets (L1).  
- **Step 3**: Join L1 with itself → candidate 2-itemsets (C2). Count supports → L2.  
- **Step 4**: Repeat for L3 until no new frequent itemsets.  

===================================================================================================================================


## 11. Generating Association Rules  

Once frequent itemsets are found:  

1. Generate all **nonempty subsets** of each frequent itemset.  
2. For each subset *s* of itemset *l*, generate rule: *(l – s) → s*.  
3. Compute **confidence**:  
   - Conf(A → B) = Support(A∪B) / Support(A).  
4. Keep only rules where confidence ≥ min_conf.  

===================================================================================================================================


## 12. Example of Rule Generation  

- Suppose frequent itemset: **l = {I1, I2, I5}**.  
- Subsets: {I1, I2}, {I1, I5}, {I2, I5}, {I1}, {I2}, {I5}.  
- Possible rules:  
  - {I1, I2} → I5  
  - {I1, I5} → I2  
  - {I2, I5} → I1  
  - {I1} → {I2, I5}  
  - {I2} → {I1, I5}  
  - {I5} → {I1, I2}  
- Compute confidence for each.  
- If min_conf = 70%, only rules meeting/exceeding 70% are retained.  

===================================================================================================================================


# Detailed Terminology List  

- **Model** – Global description of a dataset (descriptive or predictive).  
- **Pattern** – Local feature in data.  
- **Association** – Descriptive mining function identifying co-occurrence.  
- **Market Basket Analysis** – Analysis of co-purchased items.  
- **Frequent Pattern** – Itemsets or sequences appearing often in data.  
- **Association Rule** – A → B relationship between items.  
- **Support** – Frequency of co-occurrence of items.  
- **Confidence** – Probability that B occurs given A.  
- **Minimum Support (min_sup)** – User-set threshold for frequency.  
- **Minimum Confidence (min_conf)** – User-set threshold for certainty.  
- **Apriori Algorithm** – Iterative method for mining frequent itemsets.  
- **Apriori Property** – All subsets of a frequent itemset must be frequent.  
- **Antimonotone Property** – If a set fails min_sup, all supersets fail too.  
- **Join Step** – Generate candidate itemsets by joining smaller ones.  
- **Prune Step** – Eliminate candidates failing thresholds.  
- **Multidimensional Rule** – Association rule involving multiple attributes.  

===================================================================================================================================
