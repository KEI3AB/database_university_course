CREATE TABLE "category" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE "medicine" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id INTEGER NOT NULL,

    medicine_name TEXT NOT NULL,
    
    manufacturer TEXT NOT NULL,
    country TEXT NOT NULL,

    CONSTRAINT fk_medicine_category
        FOREIGN KEY (category_id)
        REFERENCES "category"(id)
        ON DELETE RESTRICT
);

CREATE TABLE "supplier" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    contract_number TEXT NOT NULL,
    city TEXT NOT NULL,
    contract_agreement_date DATE
);

CREATE TABLE "order" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_id INTEGER NOT NULL,

    receipt_date_expected DATE,
    receipt_date_actual DATE,

    cost INTEGER
        CHECK (cost > 0),

    created_at DATE DEFAULT NOW() NOT NULL,

    CONSTRAINT fk_order_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES "supplier"(id)
        ON DELETE SET NULL
);

CREATE TABLE "order_line" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    medicine_id INTEGER NOT NULL,

    quantity INTEGER
        CHECK (quantity > 0),

    cost INTEGER
        CHECK (cost > 0),
    
    CONSTRAINT fk_order_line_order
        FOREIGN KEY (order_id)
        REFERENCES "order"(id)
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_order_line_medicine
        FOREIGN KEY (medicine_id)
        REFERENCES "medicine"(id)
        ON DELETE RESTRICT
);

CREATE TABLE "stock" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    sku TEXT NOT NULL,
    
);
