-- Внутреннее соединение (JOIN)
-- 1. Бизнес смысл:
-- Формирование понятного для человека реестра продаж. Вместо сухих buyer_id пользователь
-- видит реальные названия компаний-контрагентов рядом с датами их заказов
SELECT i.id AS invoice_number,
       b.name AS buyer_name,
       i.invoice_date
    FROM "invoice" i
    JOIN "buyer" b ON i.buyer_id = b.id;

-- Внутреннее соединение с группировкой
-- 2. Бизнес смысл:
-- АВС-анализ продаж. Запрос показывает, какие детали приносят предприятию наибольшую выручку (хиты продаж).
-- Это критически важно для отдела закупок - чтобы понимать, производство каких деталей нужно масштабировать
SELECT d.name AS detail_name,
       SUM(il.quantity) AS total_sold_quantity,
       SUM(il.quantity * il.price) / 10000.0 AS total_revenue_rub
    FROM "invoice_line" il
    JOIN "detail" d ON il.detail_id = d.id
    GROUP BY d.id, d.name
    ORDER by total_revenue_rub DESC;

-- Левостороннее соединение (LEFT JOIN)
-- 3. Бизнес смысл:
-- Поиск клиентов, с которыми заключен договор, но они еще ничего не купили (или перестали покупать).
-- Результат этого запроса передается менеджерам по продажам для "прозвона" и реактивации клиента
SELECT b.name, b.city, b.contract_date
    FROM "buyer" b
    LEFT JOIN "invoice" i ON b.id = i.buyer_id
    WHERE i.id IS NULL;

-- Левостороннее соединение с временным ограничением
-- 4. Бизнес смысл:
-- Аудит движения конкретных позиций за строгий период. Выводит весь прайс-лист деталей, но подтягивает историю
-- складских списаний только если они произошли в первой декаде октября. Позиции без продаж в этот период
-- будут иметь пустоту (NULL) в правых столбцах, что указывает на отсутствие спроса
SELECT d.name, sh.sale_date, sh.old_quantity, sh.new_quantity
    FROM "detail" d
    LEFT JOIN "sales_history" sh
        ON d.id = sh.detail_id AND sh.sale_date BETWEEN '2023-10-01' AND '2023-10-11'
	WHERE sh.id IS NULL;

SELECT d.name,
	   NULL AS sale_date,
	   NULL AS old_quantity,
	   NULL AS new_quantity
	FROM "detail" d
	WHERE NOT EXISTS (
		SELECT 1
			FROM "sales_history" sh
			WHERE sh.detail_id = d.id
				AND sh.sale_date BETWEEN '2023-10-01' AND '2023-10-11'
	);

-- Простой подзапрос
-- 5. Бизнес смысл:
-- Автоматическое выделение товаров, чья стоимость превышает среднюю по всему складу. Менеджер использует
-- это для создания прайс-листа категории "Премиум" или для анализа затоваренности дорогими позициями.
SELECT name, material, price / 10000.0 AS price_rub
    FROM "detail"
    WHERE price > (SELECT AVG(price) FROM "detail")
