-- Show each patient with their service's average satisfaction as an additional column.

SELECT p.patient_id, p.name, p.service, p.satisfaction,
(
SELECT ROUND (AVG(p2.satisfaction),2)
FROM patients p2
WHERE p2.service = p.service
) AS service_avg_satisfaction
FROM patients p;

-- Create a derived table of service statistics and query from it.

SELECT
stats.service,
stats.total_patients,
stats.avg_satisfaction,
stats.avg_age
FROM (
SELECT
service,
COUNT(patient_id) AS total_patients,
ROUND(AVG(satisfaction), 2) AS avg_satisfaction,
ROUND(AVG(age), 2) AS avg_age
FROM patients
GROUP BY service)
AS stats;

-- Display staff with their service's total patient count as a calculated field.

SELECT
s.staff_id,
s.staff_name,
s.service,
(
SELECT COUNT(p.patient_id)
FROM patients p
WHERE p.service = s.service
) AS total_patients_in_service
FROM staff s;

-- Create a report showing each service with: service name, total patients admitted,
-- the difference between their total admissions and the average admissions across all services,
-- and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.

SELECT
  svc_stats.service,
  svc_stats.total_patients,
  (svc_stats.total_patients - avg_tbl.avg_patients) AS admissions_difference_vs_avg,
  CASE
    WHEN svc_stats.total_patients > avg_tbl.avg_patients THEN 'Above Average'
    WHEN svc_stats.total_patients = avg_tbl.avg_patients THEN 'Average'
    ELSE 'Below Average'
  END AS rank_indicator
FROM (
  SELECT
    service,
    COUNT(patient_id) AS total_patients
  FROM patients
  GROUP BY service
) AS svc_stats
CROSS JOIN (
  SELECT
    AVG(total_patients) AS avg_patients
  FROM (
    SELECT COUNT(patient_id) AS total_patients
    FROM patients
    GROUP BY service
  ) AS avg_calc
) AS avg_tbl
ORDER BY
  svc_stats.total_patients DESC;



























