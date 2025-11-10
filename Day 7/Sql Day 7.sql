-- Find services that have admitted more than 500 patients in total.

Select service,sum(patients_admitted) as pat_admit
from services_weekly
group by service
having pat_admit > 500;

-- Show services where average patient satisfaction is below 75.
Select service,avg(patient_satisfaction) as avg_sat
from services_weekly
group by service
having avg_sat < 75;

-- List weeks where total staff presence across all services was less than 50.
select week,sum(present) as prsnt
from staff_schedule
group by week
having prsnt < 50;

--  Identify services that refused more than 100 patients in total and
-- had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.

Select service as service_name ,sum(patients_refused) as total_refused, avg(patient_satisfaction) as avg_sat
from services_weekly
group by service
having total_refused > 100 
and avg_sat < 80;





