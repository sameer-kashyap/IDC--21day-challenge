-- Join patients and staff based on their common service field (show patient and staff who work in same service).
select p.name , s.staff_name
from patients p 
join staff s on p.service = s.service;

-- Join services_weekly with staff to show weekly service data with staff information.
select *
from services_weekly sw
join staff s on sw.service = s.service;

-- Create a report showing patient information along with staff assigned to their service.
select p.* , s.staff_name
from patients p 
join staff s on p.service = s.service;

-- Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service.
-- Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name.

select p.patient_id as pat_id , p.name as pat_name , p.age as pat_age , p.service as service , count(s.staff_id) as total_staff
from patients as p 
join staff s 
on p.service = s.service 
group by p.patient_id , p.name , p.age , p.service
having count(s.staff_name) > 5
order by total_staff desc , pat_name;









