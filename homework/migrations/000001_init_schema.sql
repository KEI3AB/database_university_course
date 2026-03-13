CREATE TABLE "detail" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    
    name TEXT NOT NULL,
    material TEXT NOT NULL,

    weight INTEGER
        CHECK (weight > 0),
    price INTEGER
        CHECK (price > 0),
    stock_quantity INTEGER
        CHECK (stock_quantity >= 0),
    
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

CREATE TABLE "buyer" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name TEXT NOT NULL,
    city TEXT NOT NULL,

    contract_date DATE DEFAULT NOW() NOT NULL
);

CREATE TABLE "invoice" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    buyer_id INTEGER NOT NULL,

    invoice_date DATE DEFAULT NOW() NOT NULL,
    total_cost INTEGER
        CHECK (total_cost > 0),

    CONSTRAINT fk_invoice_buyer
        FOREIGN KEY (buyer_id)
        REFERENCES "buyer"(id)
        ON DELETE RESTRICT
);

CREATE TABLE "invoice_line" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    invoice_id INTEGER NOT NULL,
    detail_id INTEGER NOT NULL,

    quantity INTEGER
        CHECK (quantity > 0),
    price INTEGER
        CHECK (price > 0),
    
    CONSTRAINT fk_invoice_line_invoice
        FOREIGN KEY (invoice_id)
        REFERENCES "invoice"(id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_invoice_line_detail
        FOREIGN KEY (detail_id)
        REFERENCES "detail"(id)
        ON DELETE RESTRICT
);

CREATE TABLE "sales_history" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    detail_id INTEGER NOT NULL,

    old_quantity INTEGER
        CHECK (old_quantity > 0),
    new_quantity INTEGER
        CHECK (new_quantity >= 0),
    
    sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,

    CONSTRAINT fk_sales_history_detail
        FOREIGN KEY (detail_id)
        REFERENCES "detail"(id)
        ON DELETE CASCADE
);
