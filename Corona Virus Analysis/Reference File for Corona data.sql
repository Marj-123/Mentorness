
-- DATABASE CONNECTION
SELECT * FROM corona.coronavirusdataset;

USE corona;
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values

    SELECT * FROM coronavirusdataset WHERE coalesce(
   Province,Country, Latitude, Longitude, CountryDate, Confirmed, Deaths,Recovered) IS NULL;

--Q2. If NULL values are present, update them with zeros for all columns. 

    UPDATE coronavirusdataset
    SET Province = coalesce(Province, 0),
        Country = coalesce(Country, 0),
        Latitude = coalesce(Latitude, 0),
        Longitude = coalesce(Longitude, 0),
        CountryDate = coalesce(CountryDate, 0),
        Confirmed = coalesce(Confirmed, 0),
        Deaths = coalesce(Deaths, 0),
        Recovered = coalesce(Recovered, 0)
    WHERE Province IS NULL OR Country IS NULL OR Latitude IS NULL OR
            Longitude IS NULL OR CountryDate IS NULL OR Confirmed IS NULL OR 
            Deaths IS NULL OR Recovered IS NULL;

-- Q3. check total number of rows
    SELECT  COUNT(*) AS total_rows FROM corona.coronavirusdataset;
    
-- Q4. Check what is start_date and end_date
    SELECT MIN(CountryDate) AS Start_Date, MAX(CountryDate) AS End_Date FROM 
            coronavirusdataset;

-- Q5. Number of month present in dataset

    SELECT
	    COUNT(DISTINCT EXTRACT(MONTH FROM STR_TO_DATE(CountryDate, '%d-%m-%Y'))) AS total_months
    FROM coronavirusdataset;

-- Q6. Find monthly average for confirmed, deaths, recovered

    SELECT
        AVG(Confirmed) AS ave_confirmed,
        AVG(Deaths) AS ave_deaths,
        AVG(Recovered) AS ave_recovered
     FROM coronavirusdataset GROUP BY EXTRACT(MONTH FROM CountryDate);

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 

    SELECT
        MAX(Confirmed) AS most_frequent_confirmed,
        MAX(Deaths) AS most_frequent_deaths,
        MAX(Recovered) AS most_frequent_recovered
     FROM coronavirusdataset GROUP BY EXTRACT(MONTH FROM CountryDate);

-- Q8. Find minimum values for confirmed, deaths, recovered per year

    SELECT
        MIN(Confirmed) AS min_frequent_confirmed,
        MIN(Deaths) AS min_frequent_deaths,
        MIN(Recovered) AS min_frequent_recovered
     FROM coronavirusdataset GROUP BY EXTRACT(YEAR FROM CountryDate);

-- Q9. Find maximum values of confirmed, deaths, recovered per year

    SELECT
        MAX(Confirmed) AS max_per_year_confirmed,
        MAX(Deaths) AS max_per_year_deaths,
        MAX(Recovered) AS max_per_year_recovered
    FROM coronavirusdataset GROUP BY EXTRACT(YEAR FROM CountryDate);

-- Q10. The total number of case of confirmed, deaths, recovered each month

    SELECT
        sum(Confirmed) AS total_each_month_confirmed,
        sum(Deaths) AS total_each_month_deaths,
        sum(Recovered) AS total_each_month_recovered
    FROM coronavirusdataset GROUP BY EXTRACT(MONTH FROM CountryDate)
    ORDER BY EXTRACT(MONTH FROM CountryDate);

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

    SELECT 
        sum(Confirmed) AS total_confirmed_cases,
        avg(Confirmed) AS ave_confirmed_cases,
        variance(Confirmed) AS variance_confirmed_cases,
        stddev(Confirmed) AS stdev_confirmed_cases 
    FROM coronavirusdataset;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

    SELECT 
        sum(Deaths) AS total_deaths_cases,
        avg(Deaths) AS ave_deaths_cases,
        variance(Deaths) AS variance_deaths_cases,
        stddev(Deaths) AS stdev_deaths_cases 
    FROM coronavirusdataset GROUP BY EXTRACT(MONTH FROM CountryDate); 

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
    SELECT 
        sum(Recovered) AS total_recovered_cases,
        avg(Recovered) AS ave_recovered_cases,
        variance(Recovered) AS variance_recovered_cases,
        stddev(Recovered) AS stdev_recovered_cases 
    FROM coronavirusdataset GROUP BY EXTRACT(MONTH FROM CountryDate);

-- Q14. Find Country having highest number of the Confirmed case

    SELECT `Country`,
        Confirmed FROM coronavirusdataset WHERE
    Confirmed = (SELECT MAX(Confirmed) FROM coronavirusdataset);

-- Q15. Find Country having lowest number of the death case

        SELECT `Country`,
            MIN(Deaths) AS LowestDeaths
            FROM coronavirusdataset GROUP BY `Country`
        ORDER BY LowestDeaths ASC LIMIT 5;

-- Q16. Find top 5 countries having highest recovered case

        SELECT `Country`, sum(Recovered) AS HighestRecovered
        FROM coronavirusdataset GROUP BY `Country`
        ORDER BY HighestRecovered DESC LIMIT 5;