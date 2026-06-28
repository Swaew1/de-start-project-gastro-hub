/*добавьте сюда запросы для решения задания 6*/
BEGIN; 
-- Пояснение:
-- Используем команду LOCK TABLE в режиме SHARE. 
-- Этот режим разрешает параллельный SELECT,
-- но полностью запрещает любые операции изменения данных (INSERT, UPDATE, DELETE) 
-- и другие блокировки до конца транзакции.
LOCK TABLE cafe.managers IN SHARE MODE;
ALTER TABLE cafe.managers ADD COLUMN phone_array text[];
WITH ranked_managers AS (
    SELECT 
        manager_uuid,
        phone AS old_phone,
        CONCAT('8-800-2500-', 100 + (ROW_NUMBER() OVER (ORDER BY name) - 1)) AS new_phone
    FROM cafe.managers
)
UPDATE cafe.managers m
SET phone_array = ARRAY[u.new_phone, u.old_phone]
FROM ranked_managers u
WHERE m.manager_uuid = u.manager_uuid;
ALTER TABLE cafe.managers DROP COLUMN phone;
ALTER TABLE cafe.managers RENAME COLUMN phone_array TO phone;
COMMIT;
