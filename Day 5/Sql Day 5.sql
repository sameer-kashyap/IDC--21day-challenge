-- Practice Questions:
-- Count the total number of patients in the hospital.

Select count(*) as Total_patients from patients;

-- Calculate the average satisfaction score of all patients.

select round(avg(satisfaction),2) as AVG_Satisfaction from patients;

-- Find the minimum and maximum age of patients.

select min(age) as Min_age , max(age) as Max_age from patients;

-- Daily Challenge:
-- Calculate the total number of patients admitted, total patients refused, 
-- and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.

SELECT Sum(patients_admitted) as Total_Patient_Admit ,
Sum(patients_refused) as Total_Patient_refuse,
round(avg(patient_satisfaction),2) as Avg_Satisfaction 
FROM idc.services_weekly;



