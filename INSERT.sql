/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
INSERT INTO cafe.restaurants (name, type, menu)
SELECT DISTINCT 
    m.cafe_name, 
    s.type::cafe.restaurant_type,
    m.menu
FROM raw_data.menu m
JOIN raw_data.sales s ON m.cafe_name = s.cafe_name;

SELECT * FROM cafe.restaurants r ;

INSERT INTO cafe.managers (name, phone)
SELECT DISTINCT 
    s.manager,
    s.manager_phone
FROM raw_data.sales s;

INSERT INTO cafe.restaurant_manager_work_dates (restaurant_uuid, manager_uuid, start_date, end_date)
SELECT 
    r.restaurant_uuid,  
    m.manager_uuid,    
    MIN(s.report_date),
    MAX(s.report_date)
FROM raw_data.sales s
JOIN cafe.restaurants r ON s.cafe_name = r.name 
JOIN cafe.managers m ON s.manager = m.name 
GROUP BY r.restaurant_uuid, m.manager_uuid;

INSERT INTO cafe.sales (date, restaurant_uuid, avg_check)
SELECT  
    s.report_date, 
    r.restaurant_uuid,
    s.avg_check
FROM raw_data.sales s 
JOIN cafe.restaurants r ON s.cafe_name = r.name;
