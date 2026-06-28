/*добавьте сюда запрос для решения задания 5*/
WITH menu_cte AS (
    SELECT 
        r.name AS restaurant_name,
        'Пицца'::text AS dish_type, 
        menu_items.key AS pizza_name,
        menu_items.value::int AS price 
    FROM cafe.restaurants r,
    jsonb_each_text(r.menu -> 'Пицца') AS menu_items
    WHERE r.type = 'pizzeria'
),
menu_with_rank AS (
    SELECT 
        restaurant_name,
        dish_type,
        pizza_name,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY restaurant_name 
            ORDER BY price DESC
        ) AS rnk
    FROM menu_cte
)
SELECT 
    restaurant_name,
    dish_type,
    pizza_name,
    price
FROM menu_with_rank
WHERE rnk = 1
ORDER BY restaurant_name ASC;
