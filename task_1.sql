/*добавьте сюда запрос для решения задания 1*/
CREATE VIEW cafe.top_restaurants AS 
WITH ranked_cafes AS (
SELECT 
     r.name AS restaurant_name,
     r.type AS restaurant_type,
     ROUND(AVG(s.avg_check), 2) AS average_check,
     dense_rank() OVER (PARTITION BY r.type ORDER BY AVG(s.avg_check) DESC) AS rnk
FROM cafe.restaurants r
JOIN cafe.sales s using(restaurant_uuid)
GROUP BY r.name, r.type 
)
SELECT  
    restaurant_name, 
    restaurant_type,
    average_check 
FROM ranked_cafes 
WHERE rnk <= 3 
ORDER BY restaurant_type, average_check DESC;
