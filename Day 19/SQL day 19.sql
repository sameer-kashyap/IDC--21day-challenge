-- Rank patients by satisfaction score within each service.
select patient_id , name , age , service , satisfaction ,
rank() over (partition by service order by satisfaction) as Rank_pat
from patients ;

-- Assign row numbers to staff ordered by their name.
select staff_id , staff_name , role , service ,
row_number() over (order by staff_name) as indx
from staff;

-- Rank services by total patients admitted.
SELECT service, COUNT(patient_id) as total_patients,
RANK() OVER (ORDER BY COUNT(patient_id) DESC) as rank_service
FROM patients
GROUP BY service;

-- For each service, rank the weeks by patient satisfaction score (highest first).
-- Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.


select t.* from
(select service, week, patient_satisfaction, patients_admitted,
row_number() over(partition by service order by patient_satisfaction desc) as rnk
from services_weekly) as t
where t.rnk <= 3;







