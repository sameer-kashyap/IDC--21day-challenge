-- Combine patient names and staff names into a single list.

select name as name , 'Patient' As Source 
from Patients
Union all
select staff_name as name , 'Staff' As Source
from staff;

-- Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).

Select patient_id , name , age , 'High Satisfaction' As Satisfaction from patients where satisfaction > 90
union all 
select patient_id , name , age , 'Low Satisfaction' As Satisfaction from patients where satisfaction < 50;

-- List all unique names from both patients and staff tables.
select distinct(name) ,'Patient' As Source from patients
union 
select distinct(staff_name) , 'Staff' As Source from staff; 


-- Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name,
-- type ('Patient' or 'Staff'), and associated service.
--  Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.

select patient_id , name as full_name , 'Patient' as `type` , service
from patients 
where service in ('surgery','emergency')
union all 
select staff_id , staff_name as  full_name , 'Staff' as `type` , service
from staff
where service in ('surgery','emergency')
order by type , service ,full_name;




















