CREATE VIEW v_invoice_totals AS
SELECT i.id AS invoice_id,
       i.invoice_date,
       b.name AS buyer_name,
       SUM(il.quantity * il.price) / 10000.0 AS actual_total_rub
    FROM "invoice" i
    JOIN "buyer" b ON i.buyer_id = b.id
    JOIN "invoice_line" il ON i.id = il.invoice_id
    GROUP BY i.id, i.invoice_date, b.name;

-- Сложный запрос, использующий VIEW
SELECT buyer_name, invoice_id, actual_total_rub
FROM v_invoice_totals
WHERE actual_total_rub > 10000 -- ищем чеки на сумму более 10_000 рублей
ORDER BY actual_total_rub DESC;
