/*добавьте сюда запросы для решения задания 6*/
BEGIN; 
-- Пояснение:
-- Используем блокировку строк FOR UPDATE
-- Она блокирует только те записи ресторанов, где в меню есть 'Капучино'.
-- Другие пользователи смогут читать эти строки, а также 
-- изменять любые другие рестораны, где капучино нет.
WITH update_menu AS (
    SELECT  
        restaurant_uuid, 
        jsonb_set(menu, '{Кофе, Капучино}', (round((menu -> 'Кофе' ->> 'Капучино')::int*1.2))::text::jsonb) AS new_menu 
    FROM cafe.restaurants 
    WHERE menu -> 'Кофе' ->> 'Капучино' IS NOT NULL 
    FOR UPDATE
) 
UPDATE cafe.restaurants r 
SET menu = u.new_menu 
FROM update_menu u  
WHERE r.restaurant_uuid = u.restaurant_uuid; 
COMMIT;
