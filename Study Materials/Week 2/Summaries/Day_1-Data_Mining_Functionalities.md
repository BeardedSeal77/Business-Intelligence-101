# Data Mining Functionalities – Complete Study Guide  

===================================================================================================================================

## 1. Introduction to Data Mining  

### What is Data Mining?  
- **Definition**: Data mining (or **Knowledge Discovery in Databases – KDD**) is the process of extracting knowledge from large volumes of data.  
- It involves analyzing **large observational datasets** stored in databases, warehouses, files, or other repositories.  
- The aim is to discover **non-trivial, implicit, previously unknown, and potentially useful patterns**.  

### Why Data Mining?  
- Modern organizations face a *data-rich but information-poor* situation:  
  - Example: Retailers collect massive transaction logs but cannot use them directly without analysis.  
- Data mining provides **powerful analysis and interpretation tools** to uncover hidden insights.  
- Outcomes support **decision-making, forecasting, and strategic planning**.  

### Data Mining vs Statistics  
- **Data Mining** deals with existing observational data, often collected for other purposes.  
- **Statistics** involves designing experiments to collect specific data to answer pre-defined questions.  
- Data mining is **exploratory**; statistics is usually **confirmatory**.  

===================================================================================================================================

## 2. Problems with Large Data  

When working with massive datasets, several challenges arise:  
1. **Storage & Access** – How to efficiently store and retrieve huge datasets.  
2. **Representativeness** – Ensuring that the data sample represents the population.  
3. **Efficiency of Analysis** – Algorithms must work in reasonable time despite data size.  
4. **Chance Correlations** – Distinguishing true patterns from random noise.  
5. **Sampling** – Often only a subset of data is available; results must generalize to the population.  

===================================================================================================================================

## 3. Knowledge Discovery in Databases (KDD)  

Data mining is one step in the **larger KDD process**.  

**Steps in the KDD Process**:  
1. **Data Cleaning** – Handle missing values, noise, inconsistencies.  
2. **Data Integration** – Merge data from multiple sources (databases, files, web).  
3. **Data Selection** – Extract task-relevant subsets of data.  
4. **Data Transformation** – Normalize, aggregate, and format data for mining.  
5. **Data Mining** – Apply algorithms to extract patterns (e.g., classification, clustering).  
6. **Pattern Evaluation** – Identify interesting patterns using measures like support and confidence.  
7. **Knowledge Presentation** – Visualize results (tables, graphs, decision trees, dashboards).  

**Key point**: Data mining is the **core step** but not the entire process.  

===================================================================================================================================

## 4. Major Components of a Data Mining System  

1. **Data Sources**:  
   - Databases, data warehouses, files, web, data streams.  

2. **Database/Data Warehouse Server**:  
   - Responsible for fetching task-relevant data.  

3. **Knowledge Base**:  
   - Domain knowledge (e.g., concept hierarchies such as *age → child, adult, senior*).  
   - Guides search and evaluates interestingness of patterns.  

4. **Data Mining Engine**:  
   - Functional modules for tasks: characterization, association, classification, prediction, clustering, outlier analysis, evolution analysis.  

5. **Pattern Evaluation Module**:  
   - Uses interestingness measures (support, confidence, novelty, utility).  
   - Helps filter useful results.  

6. **User Interface**:  
   - Allows users to interact, define queries, browse data, and visualize patterns (graphs, cubes, reports).  

===================================================================================================================================

## 5. Data Mining on Different Types of Data  

Data mining can be applied to:  
- **Relational Databases** (tables).  
- **Data Warehouses** (OLAP cubes).  
- **Transactional Databases** (point-of-sale records).  
- **Advanced Databases** (object-relational, multimedia).  
- **Flat Files** (CSV, text).  
- **Data Streams** (IoT, real-time analytics).  
- **Web Data** (clickstreams, logs).  
- **Application-Oriented Databases**: spatial, time-series, text, multimedia.  

===================================================================================================================================


## 6. Data Mining Functionalities  

### Overview  
Two main categories:  
1. **Descriptive tasks** – Summarize data properties.  
2. **Predictive tasks** – Make predictions based on current data.  

### Six Core Functionalities  
1. **Concept/Class Description**: Characterization & Discrimination  
2. **Frequent Patterns, Associations, and Correlations**  
3. **Classification & Prediction**  
4. **Clustering**  
5. **Outlier Analysis**  
6. **Evolution Analysis**  

===================================================================================================================================


### 6.1 Concept/Class Description  

- Data is associated with **classes** (e.g., product types) or **concepts** (e.g., “big spenders”).  
- Goal: Summarize or compare classes.  

**Types**:  
1. **Characterization** – Summarize general properties of a target class.  
   - Example: Customers spending >$1000 per year are typically aged 40–50, employed, with excellent credit.  
2. **Discrimination** – Compare target class with contrasting classes.  
   - Example: Frequent buyers of computer products vs rare buyers (age, education, income differences).  

===================================================================================================================================


### 6.2 Frequent Patterns, Associations, and Correlations  

- **Frequent Pattern**: Itemsets/events that occur often.  
- **Association Rule**: *A → B* relationship between items.  

**Measures**:  
- **Support (P(A∪B))** = probability that both A and B appear.  
- **Confidence (P(B|A))** = probability B appears when A appears.  

**Types of Patterns**:  
- **Itemsets** – Items purchased together (e.g., milk + bread).  
- **Sequential Patterns** – Events in order (e.g., buy PC → camera → memory card).  
- **Substructures** – Graphs, trees, networks.  

**Example**:  
- Rule: *Buys(computer) → Buys(software)* [Support = 1%, Confidence = 50%].  

===================================================================================================================================


### 6.3 Classification & Prediction  

- **Classification**: Assign objects to predefined categories (supervised learning).  
  - Techniques: Decision trees, IF-THEN rules, Naïve Bayes, Neural Networks, SVM, k-NN.  
- **Prediction**: Estimate continuous values (numeric).  
  - Methods: Regression analysis, time-series forecasting.  

**Examples**:  
- Classification: Predict whether a loan applicant will default.  
- Prediction: Forecast stock price next month.  

**Key point**:  
- Classification = categorical output.  
- Prediction = numeric output.  

===================================================================================================================================

### 6.4 Clustering  

- Group data into clusters without predefined labels (unsupervised learning).  
- Goal:  
  - Maximize intra-cluster similarity.  
  - Minimize inter-cluster similarity.  
- Example: Market segmentation of customers.  

===================================================================================================================================

### 6.5 Outlier Analysis  

- **Outliers** = data that deviate significantly from other observations.  
- Can be noise (irrelevant) or signal (important).  
- Example: Fraud detection – unusually large transactions compared to typical spending.  

===================================================================================================================================


### 6.6 Evolution Analysis  

- Models **trends and changes over time**.  
- Techniques: Time-series analysis, periodicity detection, similarity-based analysis.  
- Example: Study stock market data to identify future investment trends.  

===================================================================================================================================

## 7. Interestingness of Patterns  

Not all discovered patterns are useful.  

**Interestingness Criteria**:  
- Understandable to humans.  
- Valid on test data.  
- Useful for decision-making.  
- Novel or unexpected.  

**Measures**:  
- **Support** – Frequency of occurrence.  
- **Confidence** – Strength of association.  
- **Thresholds** – Patterns below thresholds are discarded.  

===================================================================================================================================

## 8. Data Mining Systems  

### Categorization  
1. **By Data Source**: Relational, warehouse, multimedia, web, text.  
2. **By Knowledge Type**: Classification, clustering, association, etc.  
3. **By Technique**: Database-oriented, machine learning, query-driven.  
4. **By Application**: Finance, telecom, DNA analysis, stock markets.  

### Data Mining Task Primitives  
- Users define data mining tasks using **primitives**:  
  1. Task-relevant data (attributes, tables, conditions).  
  2. Knowledge type (classification, clustering, etc.).  
  3. Background knowledge (concept hierarchies, user beliefs).  
  4. Interestingness measures (support, confidence, novelty).  
  5. Visualization form (tables, graphs, decision trees).  

===================================================================================================================================

## 9. Data Mining Query Language (DMQL)  

- Language for defining mining tasks.  
- Provides flexibility, user interaction, and integration with other systems.  
- Enables specification of:  
  - Relevant data.  
  - Knowledge type.  
  - Background knowledge.  
  - Interestingness thresholds.  
  - Output format (tables, charts, cubes).  

===================================================================================================================================


## 10. Major Issues in Data Mining  

1. **Mining Methodology & User Interaction**:  
   - Different kinds of knowledge.  
   - Mining at multiple levels of abstraction.  
   - Incorporating background knowledge.  
   - Handling noisy/incomplete data.  
   - Evaluating interestingness.  

2. **Performance Issues**:  
   - Efficiency of algorithms.  
   - Scalability to large datasets.  
   - Parallel, distributed, and incremental mining.  

3. **Database Diversity**:  
   - Structured, semi-structured, unstructured data.  
   - Mining across heterogeneous and global databases.  

===================================================================================================================================

# Detailed Terminology List  

- **KDD** – Knowledge Discovery in Databases; entire process of extracting useful knowledge.  
- **Data Mining** – Core step in KDD: applying algorithms to discover patterns.  
- **Characterization** – Summarizing key features of a class.  
- **Discrimination** – Comparing target vs contrasting classes.  
- **Frequent Pattern** – Set of items/events occurring frequently.  
- **Association Rule** – Rule showing item relationships (A → B).  
- **Support** – Frequency of itemset occurrence.  
- **Confidence** – Probability of consequent given antecedent.  
- **Classification** – Assigning to predefined categories.  
- **Prediction** – Estimating numerical outcomes.  
- **Clustering** – Grouping without predefined categories.  
- **Outlier** – Anomalous data point.  
- **Evolution Analysis** – Studying trends over time.  
- **DMQL** – Data Mining Query Language; defines mining tasks.  
- **Interestingness Measures** – Support, confidence, novelty, utility.  
- **Intra-cluster similarity** – Similarity within cluster.  
- **Inter-cluster similarity** – Difference between clusters.  
- **Pattern Evaluation** – Process of determining which results are useful.  
- **Task Primitives** – Building blocks to define mining tasks.  

===================================================================================================================================
