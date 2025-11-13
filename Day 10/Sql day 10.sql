-- Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.

select satisfaction ,
case 
	when satisfaction >85 then 'High'
    when satisfaction > 70 then 'Medium'
    else 
		'Low'
end as satis_categ
from patients;

-- Label staff roles as 'Medical' or 'Support' based on role type.

Select role ,
	case
		when role = 'Doctor' or role = 'Nurse' then 'Medical'
	else 'support'
        
	end as staff_role
from staff;

-- Create age groups for patients (0-18, 19-40, 41-65, 65+).

select age ,
	case 
		when age <=18 then '0-18'
        when age <=40 then '19-40'
        when age <=65 then '41-65'
	else '65+'
	end as age_group
from patients;

-- Create a service performance report showing service name, total patients admitted, 
-- and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65,
-- otherwise 'Needs Improvement'. Order by average satisfaction descending.
select service , sum(patients_admitted) as total_patients , avg(patient_satisfaction) as avg_sat,
case 
	when avg(patient_satisfaction) >= 85 then 'Excellent'
    when avg(patient_satisfaction) >= 75 then 'Good'
    when avg(patient_satisfaction) >= 65 then 'Fair'
else 'Needs Improvement'
end as performance_category
from services_weekly
group by service
order by avg_sat desc;
    




