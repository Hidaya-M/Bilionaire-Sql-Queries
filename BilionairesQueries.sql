
select *  FROM [SqlBilionares].[dbo].[bilionaire]

--Which are the top 5 categories with the highest number of billionaires?
SELECT TOP 5 category, COUNT(DISTINCT personName) AS BilionaireNumber
FROM [SqlBilionares].[dbo].[bilionaire]
GROUP BY category
ORDER BY BilionaireNumber DESC;

--Which are the top 5 country with the highest number of billionaires?
SELECT TOP 5 country, COUNT(DISTINCT personName) AS BilionaireNumber
FROM [SqlBilionares].[dbo].[bilionaire]
GROUP BY country
ORDER BY BilionaireNumber DESC;

--Which country has the highest number of billionaires?
SELECT TOP 1 country, COUNT(DISTINCT personName) AS BilionaireNumber
FROM [SqlBilionares].[dbo].[bilionaire]
GROUP BY country
ORDER BY BilionaireNumber DESC;

--What is the percentage breakdown of billionaires by selfMade
SELECT selfMade,
COUNT(DISTINCT personName) AS BilionaireNumber,
 round((COUNT(DISTINCT personName) * 100.0 / (SELECT COUNT(DISTINCT personName)  FROM [SqlBilionares].[dbo].[bilionaire])),0) AS percentage
FROM [SqlBilionares].[dbo].[bilionaire]
GROUP BY selfMade
ORDER BY percentage DESC;


--What are the names and net worth of the top 10 billionaires?
SELECT DISTINCT personName, finalWorth
FROM [SqlBilionares].[dbo].[bilionaire]
ORDER BY finalWorth DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--What is the average net worth of billionaires in the Fashion & Retail category?
select avg(finalWorth) as NetWorth
FROM [SqlBilionares].[dbo].[bilionaire]
where category = 'Fashion & Retail'

--Which are the top 6 sources of wealth for billionaires?
select  source , count(distinct personName)
FROM [SqlBilionares].[dbo].[bilionaire]
group by source
order by count(distinct personName) desc
OFFSET 0 ROWS FETCH NEXT 6 ROWS ONLY;

--How many billionaires are there in each net worth range
WITH CTE_net_worth_range AS (
    SELECT 
        personName,
        CASE
            WHEN rank <= 10 THEN 'top10'
            WHEN rank BETWEEN 10 AND 20 THEN '10_20'
            WHEN rank BETWEEN 20 AND 40 THEN '20_40'
            WHEN rank BETWEEN 40 AND 50 THEN '40_50'
            ELSE 'below 50'
        END AS net_worth_range
    FROM [SqlBilionares].[dbo].[bilionaire]
)
SELECT 
    net_worth_range,
    COUNT(DISTINCT personName) AS BilionaireCount
FROM CTE_net_worth_range
GROUP BY net_worth_range
ORDER BY BilionaireCount DESC;


--How many billionaires are there in each rank?
select rank , count(distinct personName) as BilionaireCount
FROM [SqlBilionares].[dbo].[bilionaire]
group by rank

--How many billionaires are male and how many are female?
select gender , count(distinct personName) as GenderCount
FROM [SqlBilionares].[dbo].[bilionaire]
group by  gender
order by  GenderCount desc

--Is there a significant difference in the average net worth between male and female billionaires?
SELECT gender, round(AVG(finalWorth),0) AS avgNetWorth
FROM [SqlBilionares].[dbo].[bilionaire]
GROUP BY gender;

