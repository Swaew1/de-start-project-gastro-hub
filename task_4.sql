/*добавьте сюда запрос для решения задания 4*/
WITH pizza_count AS (
    SELECT 
        r.name AS restaurant_name,
        COUNT(menu_items.key) AS pizzas_quantity
    FROM cafe.restaurants r,
    jsonb_each(r.menu -> 'Пицца') AS menu_items
    WHERE r.type = 'pizzeria'
    GROUP BY r.name
)
SELECT 
    restaurant_name,
    pizzas_quantity
FROM (
    SELECT 
        restaurant_name,
        pizzas_quantity,
        DENSE_RANK() OVER(ORDER BY pizzas_quantity DESC) AS rnk
    FROM pizza_count
) ranked_pizzerias
WHERE rnk = 1;
