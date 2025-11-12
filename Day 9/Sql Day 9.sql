-- Extract the year from all patient arrival dates.
select year(arrival_date) as pat_yrs
from patients;

-- Calculate the length of stay for each patient (departure_date - arrival_date).
select name as pat_name , datediff(departure_date,arrival_date) as days_stay
from patients;

-- Find all patients who arrived in a specific month.
select * 
from patients 
where date_format(arrival_date,'%m')= '06';

-- ### Daily Challenge:
-- Calculate the average length of stay (in days) for each service, showing only services 
-- where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.

select service,round(avg(datediff(departure_date,arrival_date)),2) as avg_stay,count(name) as no_of_pat
from patients 
group by service
having avg_stay > 7
order by avg_stay desc;



