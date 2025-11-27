-- Create a CTE to calculate service statistics, then query from it.
with cte_serv as (
select service , sum(available_beds) as avail_bed , sum(patients_request)as pat_req , sum(Patients_admitted) as pat_admit
from services_weekly
group by service
)
select * from cte_serv;

-- Use multiple CTEs to break down a complex query into logical steps.
WITH
patient_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(age) AS avg_age,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
weekly_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
)
SELECT
    pm.service,
    pm.total_patients,
    pm.avg_age,
    pm.avg_satisfaction,
    sm.total_staff,
    wm.total_admitted,
    wm.total_refused,
    ROUND(100.0 * wm.total_admitted /
          (wm.total_admitted + wm.total_refused), 2) AS admission_rate
FROM patient_metrics pm
LEFT JOIN staff_metrics sm ON pm.service = sm.service
LEFT JOIN weekly_metrics wm ON pm.service = wm.service
ORDER BY pm.avg_satisfaction DESC;

-- Build a CTE for staff utilization and join it with patient data.

WITH cte1 AS (
    SELECT WEEK(arrival_date) AS week, service, name AS patient_name, age,
           DATEDIFF(departure_date, arrival_date) AS days_stayed
    FROM patients
),
cte2 AS (
    SELECT week, service, event FROM services_weekly
),
cte3 AS (
    SELECT week, service, SUM(present) AS staff_onduty
    FROM staff_schedule
    GROUP BY week, service
)
SELECT b.week, b.service, a.patient_name, a.age, b.event, a.days_stayed, c.staff_onduty
FROM cte1 a
JOIN cte2 b ON a.week = b.week AND a.service = b.service
JOIN cte3 c ON a.week = c.week AND a.service = c.service
ORDER BY b.week, a.patient_name;

-- Create a comprehensive hospital performance dashboard using CTEs. Calculate:
-- 1) Service-level metrics (total admissions, refusals, avg satisfaction),
-- 2) Staff metrics per service (total staff, avg weeks present),
-- 3) Patient demographics per service (avg age, count).
-- Then combine all three CTEs to create a final report showing service name, all calculated metrics,
-- and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.

WITH service_level_metrics AS (
    SELECT service, SUM(patients_admitted) AS total_admissions, SUM(patients_refused) AS total_refusals,AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
),
staff_metrics AS (
    SELECT service, COUNT(DISTINCT staff_id) AS total_staff, AVG(present) AS avg_weeks_present
    FROM staff_schedule -- Changed from staff_schedule to match context
    GROUP BY service
),
patient_demographics AS (
    SELECT service, AVG(age) AS avg_age, COUNT(patient_id) AS total_patients
    FROM patients
    GROUP BY service
)
SELECt s.service,s.total_admissions,s.total_refusals,s.avg_satisfaction,st.total_staff,st.avg_weeks_present,p.avg_age,p.total_patients,
    ROUND(((s.total_admissions * 100.0 / NULLIF(s.total_admissions + s.total_refusals, 0))
            + s.avg_satisfaction
        ) / 2,
    2) AS performance_score
FROM service_level_metrics s
LEFT JOIN staff_metrics st ON s.service = st.service
LEFT JOIN patient_demographics p ON s.service = p.service
ORDER BY performance_score DESC;









