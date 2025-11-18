-- Show all staff members and their schedule information (including those with no schedule entries).
select s.* , count(ss.week) as sch_week , SUM(COALESCE(ss.present, 0)) AS weeks_present
from staff s 
left join staff_schedule ss 
on s.staff_id = ss.staff_id
group by s.staff_id , s.staff_name, s.role, s.service;

-- List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
select sw.* ,s.staff_name , s.role
from services_weekly sw
left join staff s 
on sw.service = s.service ;

-- Display all patients and their service's weekly statistics (if available).
select 
p.name,p.age,sw.week,sw.available_beds,sw.patients_request,sw.patients_refused
from patients p 
left join services_weekly sw 
on p.service = sw.service;

-- Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service)
--  and the count of weeks they were present (from staff_schedule).
-- Include staff members even if they have no schedule records. Order by weeks present descending.

SELECT
  s.staff_id,
  s.staff_name,
  s.role,
  s.service,
  SUM(COALESCE(sc.present, 0)) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule sc
  ON s.staff_id = sc.staff_id
GROUP BY
  s.staff_id, s.staff_name, s.role, s.service
ORDER BY
  weeks_present DESC;























