-- Creating a Table corona_virus and inserting columns in it.
CREATE TABLE corona_virus (
    Province VARCHAR(100), CountryRegion VARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT,
    Date DATE,
    Confirmed INT,
    Deaths INT,
    Recovered INT
);
SELECT * FROM corona_virus

-- Importing the datset directly in PGADMIN4


-- 01. Write a code to check for NULL values
select * from corona_virus
where province is null
or countryregion is null
or latitude is null
or longitude is null
or date is null
or confirmed is null
or deaths is null
or recovered is null;   


-- 02. If NULL values are present, update them with zeros for all columns
update corona_virus set 
	Province = coalesce(Province, 'Not Available'),
	Countryregion = coalesce(Countryregion, 'Not Available'),
	Latitude = coalesce(Latitude, 0.0),
	Longitude = coalesce(Longitude, 0.0),
	Date = coalesce(Date, '1970-01-01'::Date),
	Confirmed = coalesce(Confirmed, 0),
	Deaths = coalesce(Deaths, 0),
	Recovered = coalesce(Recovered, 0);


-- 03. Check Total number of rows	
select count(*) as total_rows from corona_virus;


-- 04. Check what is start_date and what is the end_date
select min(date) as start_date, max(date) as end_date from corona_virus;


-- 05. Number of month present in Dataset
select extract(month from date) as month_number,
	   count(*) as month_count from corona_virus group by month_number order by month_number;


-- 06. Find monthly average for confirmed, deaths and recovered
select extract (year from date) as year,
extract (month from date) as month,
round(avg(confirmed), 2) as avg_confirmed,
round(avg(deaths), 2) as avg_deaths,
round(avg(recovered), 2) as avg_recovered
from corona_virus 
group by year, month 
order by year, month;


-- 07. Find most frequent value for confirmed, deaths, recovered each month
select extract (year from date) as year,
extract (month from date) as month,
max(confirmed) as most_confirmed,
max(deaths) as most_deaths,
max(recovered) as most_recovered
from corona_virus
group by year, month
order by year, month;


-- 08. Find minimum values for confirmed, deaths, recovered per year
select extract (year from date) as year,
min (confirmed) as min_confirmed,
min (deaths) as min_deaths,
min (recovered) as min_recovered
from corona_virus
group by year
order by year;


-- 09. Find maximum values for confirmed, deaths, recovered per year
select extract (year from date) as year,
max (confirmed) as max_confirmed,
max (deaths) as max_deaths,
max (recovered) as max_recovered
from corona_virus
group by year
order by year;


-- 10. Find total number of cases of confirmed, deaths, recovered each month
select extract (year from date) as year,
extract (month from date) as month,
sum(confirmed) as total_confirmed,
sum(deaths) as total_deaths,
sum(recovered) as total_recovered
from corona_virus
group by year, month
order by year, month;


-- 11. Check how corona virus spread out with respect to confirmed cases
select extract(year from date) as year,
extract(month from date) as month,
sum(confirmed) as total_confirmed,
round(avg(confirmed), 2) as avg_confirmed,
round(variance(confirmed), 2) as variance_confirmed,
round(STDDEV(confirmed), 2) as standard_dev_confirmed
from corona_virus
group by year, month
order by year, month;


-- 12. Check how corona virus spread out with respect to death case per month
select extract (year from date) as year,
extract (month from date) as month,
sum(deaths) as total_deaths,
round(avg(deaths), 2) as avg_deaths,
round(variance(deaths), 2) as variance_deaths,
round(STDDEV(deaths), 2) as standard_dev_deaths
from corona_virus
group by year, month
order by year, month;


-- 13. Check how corona virus spread out with respect to recovered cases
select extract(year from date) as year,
extract(month from date) as month,
sum(recovered) as total_recovered,
round(avg(recovered), 2) as avg_recovered,
round(variance(recovered), 2) variance_recovered,
round(STDDEV(recovered), 2) as standard_dev_recovered
from corona_virus
group by year, month
order by year, month;


-- 14. Find the Country have highest number of confirmed cases
select countryregion,
sum(confirmed) as total_confirmed_cases from corona_virus
group by countryregion
order by total_confirmed_cases desc   
limit 1;


-- 15. Find the Country have lowest number of death cases

select countryregion,
sum(deaths) as lowest_deaths_cases from corona_virus
group by countryregion
order by lowest_deaths_cases Asc;


-- 16. Find top 5 countries have highest recovered cases
select countryregion,
sum(recovered) as total_recovered_cases
from corona_virus
group by countryregion
order by total_recovered_cases desc
limit 5;
