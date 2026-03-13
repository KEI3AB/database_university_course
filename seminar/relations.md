```mermaid
erDiagram
    category {
        INTEGER id PK
        TEXT name
    }

    medicine {
        INTEGER id PK
        INTEGER category_id FK
        TEXT name
        TEXT manufacturer
        TEXT manufacturers_country

    }

    stock {
        INTEGER id PK
        TEXT sku
        INTEGER quantity
        INTEGER price
        DATE accounting_date
        INTEGER medicine_id FK
    }

    supplier {
        INTEGER id PK
        TEXT conclusion
        TEXT name
        TEXT city
        DATE conclusion_agreement_date
    }

    order {
        INTEGER id PK
        INTEGER supplier_id FK
        DATE receipt_date
        INTEGER cost
    }

    order_line {
        INTEGER id PK
        INTEGER order_id FK
        INTEGER medicine FK
        INTEGER quantity
        INTEGER cost
    }

    category ||--o{ medicine: ""

    medicine ||--o{ stock: ""
    medicine ||--o{ order_line: ""

    supplier ||--o{ order: ""

    order ||--|{ order_line: ""
```
