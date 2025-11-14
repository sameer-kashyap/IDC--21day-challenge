-- List all unique services in the patients table.
select distinct service
from patients;

-- Find all unique staff roles in the hospital.
select distinct role 
from staff;

-- Get distinct months from the services_weekly table.
select distinct month
from services_weekly;


-- Find all unique combinations of service and event type from the services_weekly table where events are not null or none, 
-- along with the count of occurrences for each combination. Order by count descending.

SELECT
  service,event,COUNT(*) AS count_ocurr
FROM services_weekly
WHERE
  event NOT IN ('null', 'none')
GROUP BY
  service,event
ORDER BY
  count_ocurr DESC;


