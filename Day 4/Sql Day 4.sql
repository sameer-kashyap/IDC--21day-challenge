-- Display the first 5 patients from the patients table.

SELECT * FROM idc.patients
limit 5;

-- Show patients 11-20 using OFFSET
SELECT * FROM idc.patients
limit 10 offset 10;

-- Get the 10 most recent patient admissions based on arrival_date.

SELECT * FROM idc.patients
order by arrival_date desc
limit 10 ;

### Daily Challenge:

-- Question: Find the 3rd to 7th highest patient satisfaction scores from the patients table, 
-- showing patient_id, name, service, and satisfaction. Display only these 5 records

SELECT patient_id, `name` as patient_name , service , satisfaction  FROM idc.patients
order by satisfaction desc
limit 5 offset 2 ;