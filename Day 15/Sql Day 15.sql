-- Join patients, staff, and staff_schedule to show patient service and staff availability.
select p.* , ss.staff_id , ss.present
from patients p
join staff s on p.service = s.service 
join staff_schedule ss on s.staff_id = ss.staff_id;

-- Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
select sw.service,sw.week , sw.month  ,sum(sw.patients_admitted) as total_pat_admitted,count(ss.present) as total_staff_present
from services_weekly sw
join staff s on sw.service = s.service
join staff_schedule ss on ss.staff_id = s.staff_id AND sw.week = ss.week
group by sw.service ,sw.week , sw.month;


-- Create a multi-table report showing patient admissions with staff information.

SELECT DISTINCT
  p.name AS patient_name,
  p.age,
  w.event,
  w.service,
  p.arrival_date AS admitted_on,
  DATEDIFF(p.departure_date, p.arrival_date) AS days_stayed,
  s.staff_name AS assigned_staffs,
  s.role,
  CASE s.present
    WHEN 1 THEN 'Yes'
    ELSE 'No'
  END AS staff_availability
FROM patients p
JOIN services_weekly w
  ON w.service = p.service AND WEEK(p.arrival_date, 1) = w.week
JOIN staff_schedule s
  ON s.week = w.week AND s.service = w.service AND WEEK(p.arrival_date, 1) = s.week
ORDER BY admitted_on;


-- Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients refused,
-- average patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.

SELECT
  sw.service AS service_name,
  SUM(sw.patients_admitted) AS pat_admit,
  SUM(sw.patients_refused) AS pat_refused,
  AVG(sw.patient_satisfaction) AS avg_sat,
  COUNT(ss.staff_id) AS total_staff_records,
  SUM(ss.present) AS total_weeks_present
FROM services_weekly sw
LEFT JOIN staff_schedule ss
  ON sw.service = ss.service AND sw.week = ss.week
WHERE sw.week = 20
GROUP BY sw.service
ORDER BY pat_admit;