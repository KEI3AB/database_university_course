INSERT INTO "buyer" (name, city, contract_date) VALUES
	('ООО Вектор', 'Москва', '2026-01-15'),
	('ЗАО ДетальПром', 'Санкт-Петербург', '2026-03-11');

-- Шестерня: 1.5 кг (1_500_000_000 мкг), 500 руб (5_000_000 у.е.)
-- Вал: 3 кг (3_000_000_000 мкг), 1200 руб (12_000_000 у.е.)
INSERT INTO "detail" (name, material, weight, price, stock_quantity) VALUES
	('Шестерня', 'Сталь', 1500000000, 5000000, 100),
	('Вал', 'Чугун', 3000000000, 12000000, 50);

INSERT INTO "invoice" (buyer_id, invoice_date) VALUES
	(1, '2026-02-13'),
	(2, '2026-03-17');

INSERT INTO "invoice_line" (invoice_id, detail_id, quantity, price) VALUES
	(1, 1, 10, 5000000), -- 10 шестерней по 500 рублей в первую накладную
	(1, 2, 5, 12000000), -- 5 валов по 1200 рублей в первую накладную
	(2, 1, 20, 5000000); -- 20 шестерней по 500 рублей во вторую накладную

INSERT INTO "sales_history" (detail_id, old_quantity, new_quantity, sale_date) VALUES
	(1, 130, 120, '2026-02-13'),
	(2, 55, 50, '2026-02-13'),
	(1, 120, 100, '2026-03-17');
	
	
	
	