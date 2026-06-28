/*добавьте сюда запрос для решения задания 3*/
SELECT 
    r.name AS restaurant_name,
    COUNT(rm.manager_uuid) - 1 AS change_count 
FROM cafe.restaurants r 
JOIN cafe.restaurant_manager_work_dates rm USING(restaurant_uuid)
GROUP BY r.name
ORDER BY change_count DESC 
LIMIT 3;
