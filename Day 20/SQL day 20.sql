-- Calculate running total of patients admitted by week for each service.
select week ,service ,
sum(patients_admitted) over (partition by service order by week ) as pat_admit
from services_weekly;

-- Find the moving average of patient satisfaction over 4-week periods.
select week ,service , 
round(avg(patient_satisfaction) over (partition by service order by week),2) as pat_sat
from services_weekly
where week<5;

-- Show cumulative patient refusals by week across all services.

select distinct week ,
sum(patients_refused) over(order by week) as Pat_refusal
from services_weekly;

-- Create a trend analysis showing for each service and week: week number, patients_admitted, 
-- running total of patients admitted (cumulative), 3-week moving average of patient satisfaction (current week and 2 prior weeks), 
-- and the difference between current week admissions and the service average. Filter for weeks 10-20 only.

SELECT * FROM (
    SELECT service, week AS week_number, patients_admitted,
        SUM(patients_admitted) OVER(PARTITION BY service ORDER BY week) AS pat_admit,
        ROUND(AVG(patient_satisfaction) OVER(
            PARTITION BY service 
            ORDER BY week 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS three_week_patient_sat,
        (patients_admitted - ROUND(AVG(patients_admitted) OVER(PARTITION BY service), 2)) AS admission_diff
    FROM services_weekly
) AS trend_data
WHERE week_number BETWEEN 10 AND 20
ORDER BY service, week_number;












