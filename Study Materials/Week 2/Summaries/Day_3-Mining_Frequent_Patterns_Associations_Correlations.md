# Mining Frequent Patterns, Associations & Correlations – Day 3 Study Guide  

===================================================================================================================================
## 1. What is Market Basket Analysis?  

**Definition**: Market Basket Analysis is a data mining technique used to uncover associations between items that customers place together in shopping baskets. It helps businesses understand buying habits by finding which items are frequently purchased together.  

- **Input**: A dataset of market baskets (transactions).  
- **Output**: Item associations in the form of rules (e.g., *Bread → Milk*).  
- **Use Cases**: Cross-selling, product placement, promotions, catalog design.  

### Example Problem (from dataset of 25 baskets, 10 items):  
1. Find support for pairs: apples & milk, beer & water.  
2. How many item pairs if min support = 1?  
3. Which pairs fail min support = 2?  
4. Which pairs meet min support = 10?  
5. Which pairs meet min support = 5?  
6. What is the confidence (Bread → Milk)?  
7. What is the confidence (Milk → Bread)?  
8. What is the confidence (Eggs → Apples)?  

This illustrates how **support** and **confidence** are computed in practice.  

===================================================================================================================================
## 2. What is Apriori?  

**Definition**: Apriori is a classic algorithm (Agrawal & Srikant, 1994) for mining frequent itemsets and association rules from transaction databases. It works by generating candidate itemsets and testing them against the database.  

- **Key Idea**: Uses the **Apriori property** — “All nonempty subsets of a frequent itemset must also be frequent.”  
- **Method**: Iteratively generates larger itemsets from smaller ones (level-wise search).  
- **Output**: Frequent itemsets and strong association rules.  

### Limitations of Apriori  
1. Generates a **large number of candidate sets** when the database is big or min_sup is low.  
2. Requires **repeated database scans** (expensive on large datasets).  

===================================================================================================================================
## 3. What are Apriori Efficiency Improvements?  

To overcome Apriori’s inefficiency, several techniques are used:  

### 3.1 Hash-Based Technique  
- **Definition**: A pruning method where candidate itemsets are hashed into buckets.  
- **How it works**:  
  1. During database scan for L1, all 2-itemsets are hashed.  
  2. If a bucket count < min_sup, then any itemset mapping to that bucket is pruned.  
- **Result**: Reduces the size of candidate sets.  

### 3.2 Transaction Reduction  
- **Definition**: Removes unnecessary transactions from future scans.  
- **Idea**: If a transaction does not contain any frequent k-itemsets, it cannot contribute to frequent (k+1)-itemsets.  
- **Benefit**: Reduces the number of transactions to scan in later iterations.  

### 3.3 Partitioning  
- **Definition**: Divides the dataset into smaller partitions for local mining.  
- **How it works**:  
  - Phase I: Mine each partition separately for local frequent itemsets.  
  - Phase II: Combine all local frequent itemsets → global candidates. Verify with a second full scan.  
- **Benefit**: Requires only two full database scans.  

### 3.4 Sampling  
- **Definition**: Mine frequent itemsets from a random sample instead of the full dataset.  
- **Tradeoff**: Loses some accuracy, but gains efficiency.  
- **Condition**: Sample size must be large enough to approximate true frequencies.  

### 3.5 Dynamic Itemset Counting  
- **Definition**: Unlike Apriori (which adds new candidates before each scan), this method allows adding candidates dynamically during a scan.  
- **Benefit**: Reduces the number of scans.  

===================================================================================================================================

## 4. What is FP-Growth?  

**Definition**: FP-Growth (Frequent Pattern Growth) is an alternative to Apriori that avoids generating candidate sets. Instead, it compresses the dataset into a tree structure and mines frequent patterns directly.  

- **Method**: Uses **divide-and-conquer**.  
- **Steps**:  
  1. Build **FP-tree** from database.  
  2. Generate **conditional databases** for each frequent item.  
  3. Mine recursively using pattern growth.  

**Advantages**:  
- Avoids candidate explosion.  
- Requires fewer database scans.  
- Works better on dense datasets.  

---

## 5. What is an FP-Tree?  

**Definition**: An FP-tree (Frequent Pattern Tree) is a compressed representation of the transaction database used in FP-Growth.  

### Construction Process  
1. Create a root labeled “null.”  
2. Scan database → determine frequent items and sort them in descending support.  
3. Insert each transaction into the tree, sharing prefixes when possible.  
4. Maintain a **header table** with node links for efficient traversal.  

**Example**:  
- Transaction T100: {I1, I2, I5} → Path I2 → I1 → I5.  
- Transaction T200: {I2, I4} → Path shares prefix I2 with T100.  

===================================================================================================================================
## 6. What is Conditional Pattern Mining?  

**Definition**: A method of recursively mining the FP-tree.  

### Process  
1. Choose a frequent item as a **suffix pattern**.  
2. Build its **conditional pattern base** (prefix paths co-occurring with suffix).  
3. Construct a **conditional FP-tree** from this base.  
4. Generate new frequent patterns by concatenating suffix with prefix patterns.  

**Example**:  
- For item I5 → prefix paths: (I2, I1), (I2, I1, I3).  
- Conditional FP-tree: I2:2, I1:2.  
- Frequent patterns: {I2, I5}, {I1, I5}, {I2, I1, I5}.  

===================================================================================================================================
## 7. What is Vertical Data Format Mining?  

**Definition**: An alternative to horizontal transaction format.  

- **Horizontal format**: TID → itemset (e.g., T1: {Milk, Bread}).  
- **Vertical format**: Item → set of TIDs (e.g., Bread: {T1, T2}).  

### Mining Process  
- Itemset support found by intersecting TID sets.  
- Example: Bread {T1, T2} ∩ Milk {T1, T3} = {T1}.  

### Benefits  
- Efficient on **sparse datasets**.  
- Reduces scans (TID sets can be intersected directly).  

===================================================================================================================================
# Detailed Terminology List  

- **Market Basket Analysis** – Discovering which items are bought together.  
- **Apriori Algorithm** – Iterative frequent itemset mining algorithm using candidate generation.  
- **Apriori Property** – All subsets of a frequent itemset must also be frequent.  
- **Antimonotone Property** – If an itemset fails min_sup, all supersets fail too.  
- **Hash-Based Technique** – Uses hashing to prune low-support candidates.  
- **Transaction Reduction** – Removes irrelevant transactions in later scans.  
- **Partitioning** – Divides data into partitions, mines local frequent itemsets, then merges.  
- **Sampling** – Uses a smaller subset of the dataset for approximate mining.  
- **Dynamic Itemset Counting** – Adds candidates dynamically during scans.  
- **FP-Growth** – Alternative to Apriori; mines without candidate generation.  
- **FP-Tree** – Compact data structure for storing frequent items.  
- **Conditional Pattern Base** – Sub-database containing prefix paths of a suffix item.  
- **Conditional FP-Tree** – FP-tree built from conditional pattern base.  
- **Vertical Data Format** – Item-to-TID representation for efficient intersections.  

===================================================================================================================================