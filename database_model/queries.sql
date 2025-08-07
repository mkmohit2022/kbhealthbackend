CREATE TABLE institution (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE staff (
    id UUID PRIMARY KEY,
    institution_id UUID REFERENCES institution(id),
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50), 
    email VARCHAR(255) UNIQUE,  -- Field-level encrypted
    contact TEXT, -- Field-level encrypted
    created_at TIMESTAMP DEFAULT NOW()
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE patient (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL, -- Encrypted AES-256
    dob DATE,
    gender VARCHAR(10),
    encrypted_phone TEXT, -- Encrypted AES-256
    address TEXT, -- Encrypted AES-256
    created_at TIMESTAMP DEFAULT NOW()
    updated_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE checkup (
    id UUID PRIMARY KEY,
    staff_id UUID REFERENCES staff(id),
    patient_id UUID REFERENCES patient(id),
    visit_date TIMESTAMP,
    notes TEXT, -- Encrypted AES-256
    created_at TIMESTAMP DEFAULT NOW()
    updated_at TIMESTAMP DEFAULT NOW()
);

