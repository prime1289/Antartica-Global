use [Data analyst]

SELECT LeadDate, Day, [No of leads],[Time Spent on LG (in mins)] FROM AssociateKLM

--Changing the date format from timestamp to Date

SELECT Date, CONVERT(DATE,Date)
FROM AssociateKLM

ALTER TABLE AssociateKLM
ADD LeadDate DATE;

UPDATE AssociateKLM
SET LeadDate=CONVERT(DATE,Date)

--Highest Lead Generated in One Day.
SELECT LeadDate, Day, [No of leads] as Maxleads,[Time Spent on LG (in mins)]
FROM AssociateKLM
WHERE ([No of Leads]) IN 
                         (SELECT MAX([No of Leads]) as Maximum_lead
                          FROM AssociateKLM)

--Highest Lead Generated on Daily basis.
SELECT DAY, MAX([No of leads]) as Highest_Leads_On_Daily_Basis
FROM AssociateKLM
GROUP BY Day
ORDER BY CASE DAY
    WHEN 'Sunday' THEN 1
    WHEN 'Monday' THEN 2
    WHEN 'Tuesday' THEN 3
    WHEN 'Wednesday' THEN 4
    WHEN 'Thursday' THEN 5
    WHEN 'Friday' THEN 6
    WHEN 'Saturday' THEN 7
END;

--Total leads generated per day.
SELECT DAY, SUM([No of leads]) as Total_Leads_Generated_On_Daily_Basis
FROM AssociateKLM
GROUP BY Day
ORDER BY CASE DAY
    WHEN 'Sunday' THEN 1
    WHEN 'Monday' THEN 2
    WHEN 'Tuesday' THEN 3
    WHEN 'Wednesday' THEN 4
    WHEN 'Thursday' THEN 5
    WHEN 'Friday' THEN 6
    WHEN 'Saturday' THEN 7
END;

--Total generated Lead on Monthly Basis
SELECT  CASE 
        WHEN MONTH(LeadDate) = 1 THEN 'January'
        WHEN MONTH(LeadDate) = 2 THEN 'February'
        WHEN MONTH(LeadDate) = 3 THEN 'March'
        WHEN MONTH(LeadDate) = 4 THEN 'April'
        WHEN MONTH(LeadDate) = 5 THEN 'May'
        WHEN MONTH(LeadDate) = 6 THEN 'June'
        WHEN MONTH(LeadDate) = 7 THEN 'July'
        WHEN MONTH(LeadDate) = 8 THEN 'August'
        WHEN MONTH(LeadDate) = 9 THEN 'September'
        WHEN MONTH(LeadDate) = 10 THEN 'October'
        WHEN MONTH(LeadDate) = 11 THEN 'November'
        WHEN MONTH(LeadDate) = 12 THEN 'December'
    END AS MONTH,
    SUM([No of Leads])as Total_Leads_per_Month
FROM AssociateKLM
GROUP BY MONTH(LeadDate);

--Avg Lead genrated per day
SELECT DAY, ROUND(AVG([No of leads]),2) as Average_Leads_On_Daily_Basis
FROM AssociateKLM
GROUP BY Day
ORDER BY CASE DAY
    WHEN 'Sunday' THEN 1
    WHEN 'Monday' THEN 2
    WHEN 'Tuesday' THEN 3
    WHEN 'Wednesday' THEN 4
    WHEN 'Thursday' THEN 5
    WHEN 'Friday' THEN 6
    WHEN 'Saturday' THEN 7
END;

--Avg time spent on lead per day
SELECT DAY,ROUND(AVG([Time Spent on LG (in mins)]),0) as Average_Time_spent_in_MINS
FROM AssociateKLM
GROUP BY Day
ORDER BY CASE DAY
    WHEN 'Sunday' THEN 1
    WHEN 'Monday' THEN 2
    WHEN 'Tuesday' THEN 3
    WHEN 'Wednesday' THEN 4
    WHEN 'Thursday' THEN 5
    WHEN 'Friday' THEN 6
    WHEN 'Saturday' THEN 7
END;

--Total leads Generated in given time period
SELECT YEAR(LeadDate) as Given_Year_For_leads,SUM([No of leads]) as Total_leads_in_Given_Time, SUM([Time Spent on LG (in mins)]) as Total_time_spent_in_Mins
FROM AssociateKLM
GROUP BY  YEAR(LeadDate);

-- Conversation rate for leads generated per hour.
SELECT 
    SUM([No of leads]) AS TotalLeads,
    ROUND(SUM([Time Spent on LG (in mins)])/60,3) AS TotaHoursSpent,
    ROUND(SUM(([No of leads])*60) / SUM([Time Spent on LG (in mins)]),3) AS LeadsPerHour,
	ROUND((SUM(([No of leads]) * 60) / SUM([Time Spent on LG (in mins)])) * 100,2) AS ConversionRate
FROM AssociateKLM;

--Leaves taken by KLM
SELECT COUNT(LeadDate) as leave_taken
FROM AssociateKLM
WHERE [No of Leads]=0 AND [Time Spent on LG (in mins)]=0 AND Day NOT IN ('Sunday','Saturday')

--Average lead generated per day
SELECT ROUND(AVG(No_of_leads),2) AS AverageLeadsPerDay
FROM (
    SELECT Date, SUM([No of Leads]) AS No_of_leads
    FROM AssociateKLM
    GROUP BY Date
) AS DailyLeads;