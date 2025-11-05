-- List all patients sorted by age in descending order.

Select * from patients 
order by age desc;

-- Show all services_weekly data sorted by week number ascending and patients_request descending.

select * from services_weekly
order by `week` asc , patients_request desc;

-- Display staff members sorted alphabetically by their names.

select * from staff
order by staff_name asc;

### Daily Challenge:

-- Question:Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service,
-- patients_refused, and patients_request. Sort by patients_refused in descending order.

SELECT `week`,service,patients_refused , patients_request FROM idc.services_weekly
order by patients_refused desc
Limit 5;
