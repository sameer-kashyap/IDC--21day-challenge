-- Find all weeks in services_weekly where no special event occurred.
select `week`,event
from services_weekly
where event = 'none';

-- Count how many records have null or empty event values.
select count(service)
from services_weekly
where event in ('None' ,"") or event is null;

-- List all services that had at least one week with a special event.
SELECT DISTINCT service 
FROM services_weekly 
WHERE event IS NOT NULL AND event != 'none' AND event != '';

-- Analyze the event impact by comparing weeks with events vs weeks without events. 
-- Show: event status ('With Event' or 'No Event'), count of weeks, 
-- average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.

SELECT
  CASE
    WHEN event = 'none' OR event = '' OR event IS NULL THEN 'No Event'
    ELSE 'With Event'
  END AS event_status,
  COUNT(week) AS count_week,AVG(patient_satisfaction) AS avg_satis,AVG(staff_morale) AS avg_morale
FROM services_weekly
GROUP BY event_status
ORDER BY avg_satis DESC;