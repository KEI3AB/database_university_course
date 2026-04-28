CREATE TABLE "detail" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    
    name TEXT NOT NULL,
    material TEXT NOT NULL,

    weight BIGINT
        CHECK (weight > 0),
    price BIGINT
        CHECK (price > 0),
    stock_quantity INT
        CHECK (stock_quantity >= 0),
    
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

CREATE TABLE "buyer" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name TEXT NOT NULL,
    city TEXT NOT NULL,

    contract_date DATE DEFAULT NOW() NOT NULL
);

CREATE TABLE "invoice" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    buyer_id INT NOT NULL,

    invoice_date DATE DEFAULT NOW() NOT NULL,
    total_cost BIGINT DEFAULT 0
        CHECK (total_cost >= 0),

    CONSTRAINT fk_invoice_buyer
        FOREIGN KEY (buyer_id)
        REFERENCES "buyer"(id)
        ON DELETE RESTRICT
);

CREATE TABLE "invoice_line" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    
    invoice_id INT NOT NULL,
    detail_id INT NOT NULL,
    UNIQUE (invoice_id, detail_id),

    quantity INT
        CHECK (quantity > 0),
    price BIGINT
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

CREATE TABLE "sale_history" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    detail_id INT NOT NULL,

    old_quantity INT
        CHECK (old_quantity > 0),
    new_quantity INT
        CHECK (new_quantity >= 0),
    
    sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,

    CONSTRAINT fk_sale_history_detail
        FOREIGN KEY (detail_id)
        REFERENCES "detail"(id)
        ON DELETE CASCADE
);

CREATE TABLE "price_history" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    detail_id INT,

    old_price BIGINT
        CHECK (old_price > 0),
    new_price BIGINT
        CHECK (new_price > 0),
    
    change_date TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,

    CONSTRAINT fk_price_history_detail
        FOREIGN KEY (detail_id)
        REFERENCES "detail"(id)
        ON DELETE CASCADE
);
