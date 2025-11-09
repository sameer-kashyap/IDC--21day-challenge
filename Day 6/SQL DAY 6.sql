-- Count the number of patients by each service.
select service , count(name) as number_of_pat
from patients 
group by service;

-- Calculate the average age of patients grouped by service.
select service , round(avg(age),2) as avg_age
from patients 
group by service;

-- Find the total number of staff members per role.
select role , count(role)
from staff
group by role;

-- For each hospital service, calculate the total number of patients admitted, total patients refused, 
-- and the admission rate (percentage of requests that were admitted). Order by admission rate descending.

SELECT
  service,
  SUM(patients_admitted) AS total_admitted,
  SUM(patients_refused) AS total_refused,
  (SUM(patients_admitted) * 100.0 / SUM(patients_request)) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;