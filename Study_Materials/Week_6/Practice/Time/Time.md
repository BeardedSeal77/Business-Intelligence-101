# Time Intelligence Practice Questions

## Question 1 - Custom Calendar and YTD Measures

### Setup
Open the **Music Tours - Time Intelligence and Custom Calendars.pbix** file in the folder shown above. This report has the automatic calendar feature disabled.

> Note: Date fields in this report don't have an automatic calendar.

Import the **Track calendar** worksheet from the **Track calendar.xlsx** Excel file. This calendar assumes the financial year ends on the 31st of March.

**Answer:**

#### Steps:
1. Go to **Home** tab > **Get Data** > **Excel**
2. Browse to **Track calendar.xlsx** and select it
3. Check the **Track calendar** worksheet
4. Click **Load** to import the table into the data model

---

### Configuring the Calendar Table

The table has several columns related to financial periods. Configure this table so that you can use it as a calendar table. Here are some things you might need to do:

- Mark the table as a date table
- Disable any automatic summing of numeric columns
- Sort the Month and Weekday columns by appropriate columns
- Hide columns from the report view
- Create a relationship between the Track and Track calendar tables

After completing the above tasks your table should resemble the one shown below:

> The finished calendar table.

**Answer:**

#### Steps:

**1. Mark as Date Table:**
- Select the **Track calendar** table in the Fields pane
- Go to **Table tools** > **Mark as date table**
- Choose **Date** column as the date column
- Click OK

**2. Disable Automatic Summing:**
- Select the **Track calendar** table
- For each numeric column (Year, Financial quarter number, Financial month number, Day, Weekday number):
  - Right-click the column > **Properties**
  - Set **Summarize by** to **None** or **Don't summarize**

**3. Sort Columns:**
- Select **Month** column > **Column tools** > **Sort by column** > Select **Financial month number**
- Select **Weekday** column > **Column tools** > **Sort by column** > Select **Weekday number**
- Select **Financial quarter** column > **Column tools** > **Sort by column** > Select **Financial quarter number**

**4. Hide Columns:**
Hide these helper columns from report view (right-click > Hide in report view):
- Financial month number
- Weekday number
- Financial quarter number

**5. Create Relationship:**
- Go to **Model** view
- Drag from **Track calendar[Date]** to **Track[Single release date]**
- Ensure the relationship is set to **Many-to-One** (Track to Track calendar)
- Set cardinality appropriately

#### Notes:
- The Date column must be unique in the calendar table for it to be marked as a date table
- Sorting Month by month number ensures months appear in correct order (not alphabetically)
- Hiding number columns keeps the report clean while maintaining sort functionality

---

### Creating the Matrix Visual

Use the Track calendar to create the following matrix visual:

> You'll find measures in the Music Measures table to help you with this.

Apply a filter to the matrix visual so that it only shows dates from **1 April 1980**.

> You'll need to add a field to the Filters on this visual section of the Filter pane to do this.

**Answer:**

#### Steps:

**1. Create Matrix Visual:**
- Click **Matrix** visual in the Visualizations pane
- Add to **Rows**:
  - Track calendar[Financial year]
  - Track calendar[Financial quarter]
  - Track calendar[Month]
- Add to **Values** (from Music Measures table):
  - Count of Tracks
  - Count No 1 Tracks
  - Count Top 10 Tracks

**2. Apply Date Filter:**
- Select the matrix visual
- In **Filters** pane, find **Filters on this visual** section
- Drag **Track calendar[Date]** field into this section
- Set filter type to **Advanced filtering**
- Choose **is on or after**
- Enter date: **1/4/1980** (1 April 1980)
- Click **Apply filter**

#### Alternative Filter Method:
- Set filter type to **Basic filtering**
- Use the date picker to select dates from **1 April 1980** onwards
- Select **is on or after** operator

#### Notes:
- The filter ensures analysis starts at the beginning of a financial year (1 April 1980)
- This aligns with the financial year structure of the Track calendar
- The matrix should now display hierarchical time periods with corresponding track counts

---

### Year-to-Date Measures

Create a measure which shows a year-to-date count of tracks and add this to the matrix.

> Don't forget to reset the count on the end date of the financial year.

Calculate year-to-date counts for the other two measures in the matrix.

> The final matrix should resemble this.

Save and close the report.

**Answer:**

#### Steps:

**1. Create YTD Track Count Measure:**

Go to **Modeling** tab > **New Measure** and create:

```dax
YTD Track Count =
TOTALYTD(
    [Count of Tracks],
    'Track calendar'[Date],
    "3/31"
)
```

**2. Create YTD No 1 Tracks Measure:**

```dax
YTD Count No 1 Tracks =
TOTALYTD(
    [Count No 1 Tracks],
    'Track calendar'[Date],
    "3/31"
)
```

**3. Create YTD Top 10 Tracks Measure:**

```dax
YTD Count Top 10 Tracks =
TOTALYTD(
    [Count Top 10 Tracks],
    'Track calendar'[Date],
    "3/31"
)
```

**4. Add Measures to Matrix:**
- Drag all three YTD measures into the **Values** area of the matrix
- The matrix should now show both regular counts and YTD counts side by side

**5. Save and Close:**
- Save the report (Ctrl+S or File > Save)
- Close Power BI Desktop

#### DAX Explanation:

The `TOTALYTD` function calculates year-to-date totals with three parameters:
1. **Expression**: The measure to accumulate (e.g., [Count of Tracks])
2. **Date Column**: The date column from the calendar table ('Track calendar'[Date])
3. **Year End Date**: "3/31" - This is critical! It tells Power BI that the financial year ends on March 31st

#### How the "3/31" Parameter Works:

- Without this parameter, TOTALYTD would assume a calendar year (ending December 31st)
- With "3/31", the year-to-date calculation resets after March 31st each year
- April 1st becomes the start of the new financial year
- The cumulative count starts fresh from zero each April 1st

#### Example Output:

| Financial Year | Month | Track Count | YTD Track Count |
|----------------|-------|-------------|-----------------|
| FY1980/1981 | January | 5 | 50 |
| FY1980/1981 | February | 3 | 53 |
| FY1980/1981 | March | 4 | 57 |
| FY1981/1982 | April | 6 | 6 (reset!) |
| FY1981/1982 | May | 2 | 8 |

#### Notes:
- All three YTD measures must use "3/31" to align with the financial year structure
- The measures accumulate throughout the financial year and reset on April 1st
- These measures only work correctly when used with the Track calendar date table
- If the base measures ([Count of Tracks], etc.) don't exist, you'll need to create them first using COUNT or COUNTROWS functions

---

## Question 2 - Excel Power Pivot Time Intelligence

### Setup
Open the **Music Tours Basic Time Intelligence.xlsx** file in the folder shown above.

On Sheet1 you'll find a pivot table displaying a couple of measures.

### Creating the Calendar Table

We'd like to analyse these values by year and month.

In Power Pivot, choose **Design | Date Table | New** to create a new calendar table. Rename this table as **Show Calendar** and create a relationship to the Show table.

> Connect the Date column to the Show date column.

Add the Year, Month and Date fields to the pivot table on Sheet1.

> The table is now divided by dates.

### Monthly Running Total - Tickets Sold

Create a measure using the `TOTALMTD` function to calculate a monthly running total of tickets sold. Add the measure to the pivot table.

> Annoyingly, the running total makes dates on which no tickets were sold appear in the table.

To hide the dates on which no tickets were sold, update the measure to include an `IF` function which checks if the sum of tickets sold is blank.

> The table should now hide any dates with no ticket sales.

### Monthly Running Total - Show Revenue

Add another measure to calculate a monthly running total of show revenue. Add this measure to the pivot table and make sure that it doesn't cause dates with no ticket sales to appear.

> Apply some formatting to the measure.

### Sheet2 - Track Singles Analysis

On Sheet2 you'll find a pivot table showing the total length of tracks released as singles.

We'd like to group this measure by date.

Create a new calendar table called **Track calendar** and connect it to the Track table.

> Connect the Date column to the Single release date column.

Add the Year and Month columns from the Track Calendar table to the pivot table on Sheet2. Use the Row Labels filter to exclude blanks and choose to show subtotals at the top of a group.

> Each year should show a subtotal for the measure.

### Year-over-Year Comparison

Create a measure which compares the sum of single length with the same period in the previous year. You can use a combination of the `CALCULATE` and `SAMEPERIODLASTYEAR` functions to do this. Add the measure to the pivot table.

> Add conditional formatting to highlight positive and negative numbers.

### Month-over-Month Comparison

Add a measure which compares the sum of single length with the same value from one month ago. You can use the `CALCULATE` and `DATEADD` functions to do this. Add the measure to the pivot table.

> Conditional formatting might make it easier to read the results.

### Using ISINSCOPE

When comparing with the previous month, it doesn't make sense to display a value for the year. Try modifying the measure so that it only shows a result when the Month column is in scope.

> You can use the `ISINSCOPE` function to check if the Month column of the Track Calendar table is in scope.

Check that the subtotals don't appear for years for this measure.

> You should still see subtotals for the first two measures.

Save and close the file.

---

## Question 3 - Power BI Time Intelligence

### Setup
Open the **Music Tours - Basic Time Intelligence.pbix** file in the folder shown above.

On Page 1 you'll find a matrix containing the dates of shows and the tickets sold and revenue generated.

> You can use the slicer to choose different artists and tours.

### Monthly Running Total - Tickets Sold

Add a measure to create a monthly running total of tickets sold using the `TOTALMTD` function.

> Remember to reference the Date column of the automatic calendar table that is related to the Show date field, rather than just the Show date field itself.

Add the measure to the matrix.

> Annoyingly, the running total makes dates on which no tickets were sold appear in the matrix.

To hide the dates on which no tickets were sold, update the measure to include an `IF` function which checks if the sum of tickets sold is blank.

> The matrix should now hide any dates with no ticket sales.

### Monthly Running Total - Show Revenue

Add another measure to calculate a monthly running total of show revenue. Add this measure to the matrix and make sure that it doesn't cause dates with no ticket sales to appear.

> You could apply some formatting to the measure.

### Page 2 - Singles Analysis

On Page 2 you'll find a matrix showing the total length of tracks released as singles, grouped by year and month.

> The matrix has been filtered to show singles released since 1980.

### Year-over-Year Comparison

Create a measure which compares the sum of single length with the same period in the previous year. You can use a combination of the `CALCULATE` and `SAMEPERIODLASTYEAR` functions to do this. Add the measure to the matrix.

> You could add conditional formatting to highlight positive and negative numbers.

### Month-over-Month Comparison

Add a measure which compares the sum of single length with the same value from one month ago. You can use the `CALCULATE` and `DATEADD` functions to do this. Add the measure to the matrix.

> Again, conditional formatting might make it easier to read the results.

### Using ISINSCOPE

When comparing with the previous month, it doesn't make sense to display a value for the year. Try modifying the measure so that it only shows a result when the Month column is in scope.

> You can use the `ISINSCOPE` function to check if the Month column of the Single release date field is in scope.

Save and close the report.

---

## Question 4 - Custom Calendar Hierarchy

### Setup
Open the **Music Tours Custom Calendars.xlsx** file in the folder shown above.

Import the **Show calendar** worksheet from the Excel file called **Show calendar.xlsx** into the Power Pivot data model.

> Import this worksheet.

### Configure the Calendar Table

Mark the newly imported table as a date table, using the Date column as the key.

> Use the Date column as the unique identifier for the table.

Set the default summarization of any numeric columns in the table to **Do not summarize**.

> Power Pivot tries to sum values in numeric columns, like the Year column shown here. We don't want this to happen!

### Sort By Column Settings

Change the Sort by Column setting of the columns shown in the table below:

| Column | Column to sort by |
|--------|-------------------|
| Month | Month number |
| Weekday | Weekday number |

Hide the **Month number** and **Weekday number** fields from client tools so that they won't appear when you're building pivot tables.

### Create Hierarchy

Create a hierarchy starting with the Decade column. Rename the hierarchy as **Show date hierarchy** and add the columns shown below to it:

> You can create a hierarchy in the Diagram view of Power Pivot.

### Create Relationship

Create a relationship between the Show calendar and Show tables.

> Create the relationship between the columns highlighted here.

### Build Pivot Charts

Use your new calendar table to create the following pivot charts (you'll find some measures in the Show table to help you):

> Change the formatting to suit your preferences.

Add a slicer which you can use to filter all the charts by the **Weekday** column.

> Connect the slicer to each chart.

Save and close the file.

---

## Question 5 - MAM Database QTD and YTD

To start, if you haven't already done so run the script in the above folder to generate the MAM database (not for commercial use or copying).

Create quarter-to-date and year-to-date total quantity sold measures using the `TOTALQTD` and `TOTALYTD` functions:

> You'll need to import the tblPos, tblTransaction and tblCalendar tables.

Save this workbook as **Years and quarters**, then close it down.

---

## Question 6 - Regional Manager YTD Comparison

Good luck! To start, if you haven't already done so run the script in the above folder to generate the MAM database (not for commercial use or copying).

### Connect to Tables

Connect to tables as follows:

Most of the tables and relationships are as normal, but each region's RegionManagerId must tie in to the value of the StaffId field in the Staff table. You'll also need the store, point-of-sale, transaction and calendar tables.

### Task

The company manager wants to be able to compare year-to-date figures for 2010 for the various regional managers against the year-to-date figures for the corresponding previous period. Your task is to create these figures!

Here's what Wise Owl think the final answer should look like:

> The figures for the first couple of regional managers...

> You should find the `DATESYTD` function useful, as shown in the manual.

Save this workbook as **The full Monty**, and close it down.
