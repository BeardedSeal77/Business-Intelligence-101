# R Data Structures – Day 2 Study Guide

===================================================================================================================================
## 1. Special Data Types in R

R data frames can contain multiple base types. Commonly encountered types in Day 2 content include:

- **numeric / integer** – numbers (e.g., `3.14`, `42`)
- **character** – text strings (e.g., `"apple"`)
- **factor** – categorical variables with fixed *levels*
- **logical** – boolean values `TRUE` / `FALSE`
- **missing-value markers** – `NA` (“Not Available”), `NaN` (“Not a Number”), and `Inf` / `-Inf` (infinities)

**Missing values (`NA`)** are first-class citizens in R and propagate through many operations unless explicitly handled.


### Quick inspection helpers

```r
x <- c(1, 2, NA, 4, NaN, Inf, -Inf, TRUE, FALSE, "text")
typeof(x)        # "character" because mixed types coerce to character
class(x)         # "character"
is.na(x)         # identifies NA and NaN as missing
is.nan(x)        # specifically flags NaN
is.infinite(x)   # flags Inf / -Inf
anyNA(x)         # quick check: is there any NA/NaN?
```

===================================================================================================================================
## 2. Working with Factors

**Definition.** A factor encodes *qualitative/categorical* data as integer codes with attached **levels** (labels). Factors are crucial for modeling, summaries, and plotting.

### 2.1 Creating and inspecting factors

```r
species_char <- c("setosa", "versicolor", "virginica", "setosa", "setosa")
species_fac  <- factor(species_char)     # infer levels alphabetically
species_fac
levels(species_fac)                      # see level set
nlevels(species_fac)                     # count unique categories
table(species_fac)                       # frequency by level
```

> Note: Base R assigns factor levels in **alphabetical** order by default. If your preferred order is semantic (e.g., `"low" < "medium" < "high"`), set `levels=` explicitly or convert to **ordered** factor.

### 2.2 Controlling level order and labels

```r
# Custom order
sizes <- factor(c("medium", "small", "large", "small"),
                levels = c("small", "medium", "large"))
sizes

# Relabel levels
levels(sizes) <- c("S", "M", "L")
sizes

# Ordered factor for ordinal data
pain <- ordered(c("mild","severe","moderate","severe"),
                levels = c("mild","moderate","severe"))
pain
```

### 2.3 Creating a factor from numeric data (binning)

```r
set.seed(1)
ages <- sample(10:80, size = 12, replace = TRUE)

# Bin with cut() into age groups
age_grp <- cut(ages,
               breaks = c(0, 17, 35, 50, 65, Inf),
               labels = c("child","youth","adult","midlife","senior"),
               right = TRUE, include.lowest = TRUE)
data.frame(ages, age_grp)
table(age_grp)
```

### 2.4 Adding a derived factor to a data frame

```r
df <- data.frame(weight = c(48, 66, 73, 91, 55))
df$category <- cut(df$weight,
                   breaks = c(-Inf, 60, 80, Inf),
                   labels = c("light", "medium", "heavy"))
df
```

### 2.5 Dropping empty levels

When subsetting data, some factor levels may no longer appear but remain in `levels()`.

```r
sub <- subset(species_fac, species_fac != "virginica")
levels(sub)              # still has "virginica"
sub <- droplevels(sub)   # drop unused
levels(sub)
```

### 2.6 Changing level labels cleanly

```r
fruit <- factor(c("apl","ban","apl","org"))
levels(fruit) <- c("apple","banana","orange")
fruit
```

===================================================================================================================================
## 3. Working with Logical Data

**Definition.** Logical vectors store `TRUE`/`FALSE`. Many R operations return logicals (comparisons, `is.na`, `grepl`, etc.). Logical vectors are powerful for *filtering* and *aggregation*.

### 3.1 Creation, coercion, and counting

```r
v <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
as.integer(v)    # 1 0 1 1 0

# Count TRUEs (e.g., number of pass = TRUE)
sum(v)           # 3

# Proportion TRUE
mean(v)          # 0.6
```

### 3.2 Logical indexing

```r
scores <- c(55, 67, 72, 80, 49, NA)
pass   <- scores >= 60
scores[pass]      # keep those >= 60
scores[!pass]     # those below 60 (includes NA as NA comparisons are NA)

# Combine with NA-awareness
scores[pass %in% TRUE]   # retains only definite TRUE rows
```

===================================================================================================================================
## 4. Working with Missing Values (`NA`, `NaN`, `Inf`)

### 4.1 Detecting and summarizing missingness

```r
x <- c(10, NA, 30, NaN, 50, Inf, -Inf)
is.na(x)                    # TRUE for NA and NaN
is.nan(x)                   # TRUE for NaN only
anyNA(x)                    # any missing?
sum(is.na(x))               # count missing (NA + NaN)
```

### 4.2 Aggregations with NA handling

```r
mean(c(1, 2, NA, 4))              # NA
mean(c(1, 2, NA, 4), na.rm = TRUE)  # 2.333333
sum(c(1, NA, 3), na.rm = TRUE)       # 4
```

### 4.3 Making values missing (data cleaning)

```r
temp <- c(-99, 18.1, 20.5, -99, 22.0)
temp[temp == -99] <- NA   # recode sentinel to NA
temp
```

### 4.4 Coercion warnings and `NaN`

```r
bad <- c("10", "20", "oops", "40")
as.numeric(bad)  # Warning: NAs introduced by coercion
# Result: 10 20 NA 40
```

### 4.5 Infinite values and `NaN` from arithmetic

```r
1/0        #  Inf
-1/0       # -Inf
0/0        #  NaN
log(0)     # -Inf
is.infinite(c(Inf, -Inf, 5))
is.nan(c(NaN, 0/0))
```

### 4.6 Handling missing rows in data frames

```r
df <- data.frame(a = c(1, NA, 3), b = c(NA, 2, 3))
df_complete <- na.omit(df)        # drop rows with any NA
df_complete

# Keep rows that are fully observed using complete.cases
df[complete.cases(df), ]
```

### 4.7 Subsetting while dropping missings in a column

```r
df <- data.frame(x = c(1, 2, NA, 4), y = c("a","b","c","d"))
rows <- which(!is.na(df$x))
df2  <- df[rows, ]
df2
```

===================================================================================================================================
## 5. Working with Text (Character Data)

### 5.1 Creating and inspecting character vectors

```r
names <- c("Alice", "Bob", "Cleo")
length(names)
nchar(names)         # number of characters
typeof(names)        # "character"
```

### 5.2 Concatenation and templating

```r
# paste() with separator
paste("ID", 1:3, sep = "-")     # "ID-1" "ID-2" "ID-3"

# paste0() with no separator
paste0("Hello, ", names, "!")

# sprintf() for formatted strings
scores <- c(78.235, 65.1, 90.0)
sprintf("%s scored %.1f%%", names, scores)
```

### 5.3 Substrings, case, and splitting

```r
x <- "Statistics with R"
substr(x, 1, 10)     # "Statistics"
toupper(x)           # "STATISTICS WITH R"
tolower(x)           # "statistics with r"
strsplit(x, " ")     # split by space
```

### 5.4 Pattern matching: grep/grepl

```r
cities <- c("Pretoria", "Cape Town", "Port Elizabeth", "Pietermaritzburg")
grepl("^P", cities)                  # starts with P?
grep("Port", cities, value = TRUE)   # return matching values
grep("town$", tolower(cities), value = TRUE)   # ends with "town"
```

===================================================================================================================================
## 6. Column Names in Vectors, Data Frames, and Lists

### 6.1 Getting/setting names

```r
v <- 1:3
names(v) <- c("red","green","blue")
v
names(v)

df <- data.frame(height = c(170, 182), weight = c(65, 78))
names(df)
colnames(df) <- c("Height_cm","Weight_kg")
df
```

### 6.2 Finding columns by name with `match`

```r
cols <- c("Height_cm","Weight_kg","BMI")
match(c("weight_kg","BMI","Height_cm"), names(df))  # note case-sensitivity
# Better: use tolower for case-insensitive matching
match(tolower(c("weight_kg","BMI","Height_cm")), tolower(names(df)))
```

### 6.3 Renaming safely with `setNames`

```r
df <- setNames(df, c("height_cm","weight_kg"))
df
```

===================================================================================================================================

## 7. Putting It Together: Practical Example

```r
# Sample data frame with mixed types
dat <- data.frame(
  id      = 1:8,
  sex     = factor(c("F","M","M","F","F","M","M","F")),
  age     = c(21, 35, 41, 28, NA, 50, 39, 18),
  income  = c(3000, 5500, 7200, NA, 2600, 9100, 6100, 2000),
  city    = c("Pretoria","Polokwane","Cape Town","Pretoria","Port Elizabeth","Pietermaritzburg","Cape Town","Pretoria"),
  stringsAsFactors = FALSE
)

# 1) Clean missing sentinels (example)
dat$income[dat$income == -99] <- NA

# 2) Drop rows missing both key vars (complete cases on subset)
keep <- complete.cases(dat[c("age","income")])
dat2 <- dat[keep, ]

# 3) Create age group factor
dat2$age_group <- cut(dat2$age,
                      breaks = c(0, 24, 34, 44, Inf),
                      labels = c("<=24","25-34","35-44","45+"),
                      right = TRUE, include.lowest = TRUE)

# 4) Summaries by factor
aggregate(income ~ sex + age_group, data = dat2, FUN = mean, na.rm = TRUE)

# 5) Pattern matching to select city rows
subset(dat2, grepl("^P", city))
```

===================================================================================================================================
## 8. Common Pitfalls and Best Practices

- Avoid storing numbers as text; coerce safely with `as.numeric`, checking for warnings.
- Always check for missing values with `anyNA` and handle using `na.rm=TRUE`, `na.omit`, or `complete.cases`.
- For categorical variables, set meaningful level order (`ordered`) to match domain logic.
- After subsetting, call `droplevels` to remove unused factor levels and prevent confusing summaries.
- Prefer vectorized logical indexing instead of loops for filtering.


===================================================================================================================================
## 9. Quick Reference

- **Missingness**: `is.na`, `is.nan`, `anyNA`, `na.omit`, `complete.cases`
- **Factors**: `factor`, `levels`, `nlevels`, `ordered`, `cut`, `droplevels`
- **Logical**: `as.integer`, `sum`, `mean`, logical comparisons (`>`, `==`, `&`, `|`)
- **Text**: `paste`, `paste0`, `sprintf`, `substr`, `toupper`, `tolower`, `strsplit`, `grep`, `grepl`
- **Names**: `names`, `colnames`, `setNames`, `match`

===================================================================================================================================
