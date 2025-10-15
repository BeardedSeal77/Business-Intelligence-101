USE MAM
GO

CREATE PROC spCreateCalendarTable(
	@StartDate datetime = '19500101',
	@EndDate datetime = '20201231'
) AS

-- create a table of dates for use in PowerPivot

-- get rid of any old versions of table

BEGIN TRY
	DROP TABLE tblCalendar
END TRY

BEGIN CATCH
END CATCH

-- first create the table of dates
CREATE TABLE tblCalendar(
	[Date] datetime PRIMARY KEY,
	[Year] int,
	MonthNumber int,
	[MonthName] varchar(10),
	MonthNameSorted varchar(20),
	DayNumber int,
	[DayName] varchar(10),
	[Quarter] char(2)
)

-- now add one date at a time
DECLARE @i int = 0
DECLARE @curdate datetime = @StartDate

WHILE @curdate <= @EndDate
	BEGIN

		-- add a record for this date (could use FORMAT
		-- function if SQL Server 2012 or later)

		INSERT INTO tblCalendar (
			[Date],
			[Year],
			MonthNumber,
			[MonthName],
			MonthNameSorted,
			DayNumber,
			[DayName],
			[Quarter]
		) VALUES (
			@curdate,
			Year(@curdate),
			Month(@curdate),
			DateName(m,@curdate),

			-- get month name as eg "01 January" or "11 November"
			CASE
				WHEN month(@curdate) < 10 THEN '0'
				ELSE ''
			END + 

				CAST(month(@curdate) AS varchar(2)) +
				' ' + DateName(m,@curdate),
			
			Day(@curdate),
			DateName(weekday,@curdate),

			-- the quarter number
			'Q' + CAST(floor((month(@curdate)+2)/3) AS char(1))
		)

	-- increase iteration count and current date
	SET @i += 1

	SET @curdate = DateAdd(day,1,@curdate)

	-- quick check we haven't got a ridiculous loop
	IF @i > 36600
		BEGIN
			SELECT 'More than 100 years!'
			RETURN
		END
END

GO

-- try this out for 2013 dates
spCreateCalendarTable 
 
-- see if it worked
SELECT * FROM tblCalendar
