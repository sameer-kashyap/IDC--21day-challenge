-- Convert all patient names to uppercase.
select upper(name) as Pat_Name
from patients ;

-- Find the length of each staff member's name.
select length(replace(staff_name," ","")) as length
from staff;

-- Concatenate staff_id and staff_name with a hyphen separator.
select concat(staff_id,"_",staff_name) as new_name
from staff;

--  Create a patient summary that shows patient_id, full name in uppercase, service in lowercase,
-- age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length.
--  Only show patients whose name length is greater than 10 characters.


select patient_id , upper(name) as name  , lower(service) as service ,
	case 
		when age >= 65 then 'Senior'
        when age>= 18 then 'Adult'
        else 'Minor'
	end as age_category ,
length(replace(name," ","")) as name_length
from patients
where length(replace(name," ","")) > 10;