-- SQL queries for Electric Vehicle analysis

-- 1. which country has the highest number of electric vehicle registrations?

select country,count(*) as ev_count
from Electric_Vehicle_Population_Data
group by country
order by ev_count desc
limit 1;

--2.What are the top 10 cities with the highest electric vehicle adoption rates?

select city,count(*) as ev_count
from Electric_Vehicle_Population_Data
group by city
order by ev_count desc
limit 10

--3.Are there any trends in the adoption rates of BEVs and PHEVs over the years?

SELECT Model_Year,Electric_Vehicle_Type, COUNT(*) AS EV_Count
FROM Electric_Vehicle_Population_Data
GROUP BY Model_Year, Electric_Vehicle_Type
ORDER BY Model_Year;

--4. What is the average electric range of electric vehicles registered

SELECT AVG(Electric_Range) AS Avg_Electric_Range
FROM Electric_Vehicle_Population_Data;

--5. How does the distribution of electric range vary between BEVs and PHEVs?

SELECT Electric Vehicle Type, AVG(Electric Range) AS Avg_Electric_Range
FROM Electric_Vehicle_Population_Data
GROUP BY Electric Vehicle Type;

--6. Which electric vehicle manufacturer has the highest market share?

SELECT make, COUNT(*) AS ev_count
FROM Electric_Vehicle_Population_Data
GROUP BY make
ORDER BY ev_count DESC
LIMIT 1;

--7. How has the market share of different manufacturers changed over time?

select model_year,make,count(*) as ev_count
from Electric_Vehicle_Population_Data
group by model_year,make
order by model_year,ev_count desc;

--8. How does electric vehicle adoption vary across different legislative districts?

SELECT Legislative_District, COUNT(*) AS EV_Count
FROM Electric_Vehicle_Population_Data
GROUP BY Legislative_District
ORDER BY EV_Count DESC;


--9. Is there a correlation between the base MSRP and electric range of electric vehicles?

SELECT
  CASE
    WHEN "Base MSRP" < 30000 THEN 'Low'
    WHEN "Base MSRP" >= 30000 AND "Base MSRP" < 60000 THEN 'Medium'
    ELSE 'High'
  END AS price_range,
  AVG("Electric Range") AS average_electric_range
FROM
  Electric_Vehicle_Population_Data
GROUP BY
  price_range;

--10. Which electric utility companies are associated with the highest number of electric vehicle registrations?

SELECT "Electric Utility", COUNT(*) AS EV_Count
FROM Electric_Vehicle_Population_Data
GROUP BY "Electric Utility"
ORDER BY EV_Count DESC;

--11. What are the trends in electric vehicle registrations over each month?

SELECT EXTRACT(MONTH FROM "Registration Date") AS Registration_Month,
       COUNT(*) AS EV_Count
FROM Electric_Vehicle_Population_Data
GROUP BY Registration_Month
ORDER BY Registration_Month;

--12. How has the average base MSRP of electric vehicles changed over different model years?

SELECT "Model Year",
       AVG("Base MSRP") AS Avg_Base_MSRP
FROM Electric_Vehicle_Population_Data
GROUP BY "Model Year"
ORDER BY "Model Year";

--13. What are the top 10 electric vehicle models with the highest electric range?

select make,model,electric range from
Electric_Vehicle_Population_Data
order by electric range desc
limit 10;

--14.  calculate rolling averages  of electric vehicle registrations over time

SELECT
    "Model Year",
    COUNT(*) AS EV_Count,
    AVG(COUNT(*)) OVER (ORDER BY "Model Year" ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS Five_Year_Rolling_Average
FROM
    Electric_Vehicle_Population_Data
GROUP BY
    "Model Year"
ORDER BY
    "Model Year";

--15. Calculate year-over-year growth rates of electric vehicle registrations

SELECT
    "Model Year",
    COUNT(*) AS EV_Count,
    LAG(COUNT(*), 1) OVER (ORDER BY "Model Year") AS Previous_Year_EV_Count,
    (COUNT(*) - LAG(COUNT(*), 1) OVER (ORDER BY "Model Year")) / LAG(COUNT(*), 1) OVER (ORDER BY "Model Year") AS YoY_Growth_Rate
FROM
    Electric_Vehicle_Population_Data
GROUP BY
    "Model Year"
ORDER BY
    "Model Year";

--16. Calculate a moving average of electric vehicle counts over a specific time window

SELECT
  "Model Year",
  COUNT(*) AS EV_Count,
  AVG(COUNT(*)) OVER (ORDER BY "Model Year" ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Moving_Average
FROM
  Electric_Vehicle_Population_Data
GROUP BY
  "Model Year"
ORDER BY
  "Model Year";

--17. Identify the 90th percentile of electric range within the dataset

SELECT
    PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY "Electric Range") AS Ninetieth_Percentile_Range
FROM
    Electric_Vehicle_Population_Data;









