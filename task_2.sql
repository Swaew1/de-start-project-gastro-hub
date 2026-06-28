/*добавьте сюда запрос для решения задания 2*/
CREATE MATERIALIZED VIEW cafe.avg_check_time AS 
WITH cafe_years AS (
    SELECT  
        EXTRACT(YEAR FROM s.date)::int AS year,
        r.restaurant_uuid,
        r.name AS restaurant_name,
        r.type AS restaurant_type,
        ROUND(AVG(s.avg_check), 2) AS current_year_check
    FROM cafe.sales s
    JOIN cafe.restaurants r USING (restaurant_uuid)
    WHERE EXTRACT(YEAR FROM s.date) != 2023
    GROUP BY EXTRACT(YEAR FROM s.date), r.restaurant_uuid, r.name, r.type
),
cafe_with_lag AS (
    SELECT 
        year,
        restaurant_name,
        restaurant_type,
        current_year_check,
        LAG(current_year_check) OVER (
            PARTITION BY restaurant_uuid 
            ORDER BY year
        ) AS prev_year_check
    FROM cafe_years
)
SELECT 
    year,
    restaurant_name,
    restaurant_type,
    current_year_check,
    prev_year_check,
    ROUND(((current_year_check - prev_year_check) / prev_year_check * 100), 2) AS change_percentage
FROM cafe_with_lag
ORDER BY restaurant_name, year;
