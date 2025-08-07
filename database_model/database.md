# Healthcare App Databse

This folder contains the databse design for the application. The relational database (postgreSQL) is being used for the application database with few tables scema matched with SQLlite database on application so as to sync databse when the app is working on offline mode.

## Database Schema 

- Below are the tables and the required fields. THis is assumed to have a minimal implementation of a use case as the exact implementation requirements are not there.

### Tables

 institution (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

 staff (
    id UUID PRIMARY KEY,
    institution_id UUID REFERENCES institution(id),
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50), 
    email VARCHAR(255) UNIQUE,  -- Field-level encrypted
    contact TEXT, -- Field-level encrypted
    created_at TIMESTAMP DEFAULT NOW()
    updated_at TIMESTAMP DEFAULT NOW()
);

 patient (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL, -- Encrypted AES-256
    dob DATE,
    gender VARCHAR(10),
    encrypted_phone TEXT, -- Encrypted AES-256
    address TEXT, -- Encrypted AES-256
    created_at TIMESTAMP DEFAULT NOW()
    updated_at TIMESTAMP DEFAULT NOW()
);


 checkup (
    id UUID PRIMARY KEY,
    staff_id UUID REFERENCES staff(id),
    patient_id UUID REFERENCES patient(id),
    visit_date TIMESTAMP,
    notes TEXT, -- Encrypted AES-256 AES-256
    created_at TIMESTAMP DEFAULT NOW()
    updated_at TIMESTAMP DEFAULT NOW()
);

- The Personal Indentifying Information is encrypted for the patient's data and identity security. The other data like DOB, Gender, etc can be used for data analysis and the data is annonimized. Also for the searchable fields like name/email, deterministic encryption should be used. And For personal Data like, contact number, address, cheup notes can be envelope encryppted with keys managed through KMS

- The entire databse is sesured and encrypted using Transparent Data Encryption for databse.
