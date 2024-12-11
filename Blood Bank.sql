CREATE DATABASE BloodDonation;
USE BloodDonation;

CREATE TABLE DONOR (
    Donor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact_Info VARCHAR(100),
    Registration_Date DATE,
    Eligibility_Status VARCHAR(50)
);

CREATE TABLE DONOR_HEALTH (
    Health_Record_ID INT PRIMARY KEY,
    Donor_ID INT NOT NULL,
    Medical_History TEXT,
    Eligibility_Evaluation VARCHAR(50),
    Record_Date DATE,
    FOREIGN KEY (Donor_ID) REFERENCES DONOR(Donor_ID)
);

CREATE TABLE BLOOD (
    Blood_ID INT PRIMARY KEY,
    Blood_Type VARCHAR(10),
    Donation_Date DATE,
    Expiry_Date DATE,
    Status VARCHAR(50)
);

CREATE TABLE DONATION_HISTORY (
    Donation_History_ID INT PRIMARY KEY,
    Donor_ID INT NOT NULL,  -- Add NOT NULL here
    Blood_ID INT NOT NULL,  -- Add NOT NULL here
    Donation_Date DATE,
    FOREIGN KEY (Donor_ID) REFERENCES DONOR(Donor_ID),  -- No NOT NULL here
    FOREIGN KEY (Blood_ID) REFERENCES BLOOD(Blood_ID)   -- No NOT NULL here
);

CREATE TABLE BLOOD_STORAGE (
    Storage_ID INT PRIMARY KEY,
    Location VARCHAR(100),
    Capacity INT
);

CREATE TABLE BLOOD_INVENTORY (
    Inventory_ID INT PRIMARY KEY,
    Blood_ID INT NOT NULL,  -- Add NOT NULL here
    Storage_ID INT NOT NULL,  -- Add NOT NULL here
    Quantity INT,
    FOREIGN KEY (Blood_ID) REFERENCES BLOOD(Blood_ID),  -- No NOT NULL here
    FOREIGN KEY (Storage_ID) REFERENCES BLOOD_STORAGE(Storage_ID)  -- No NOT NULL here
);

CREATE TABLE HOSPITAL (
    Hospital_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Contact_Info VARCHAR(50)
);

CREATE TABLE HOSPITAL_BLOOD_REQUESTS (
    Request_ID INT PRIMARY KEY,
    Hospital_ID INT NOT NULL,  -- Add NOT NULL here
    Blood_Type_Requested VARCHAR(10),
    Quantity_Requested INT,
    Request_Date DATE,
    FOREIGN KEY (Hospital_ID) REFERENCES HOSPITAL(Hospital_ID)  -- No NOT NULL here
);

CREATE TABLE BLOOD_DELIVERY (
    Delivery_ID INT PRIMARY KEY,
    Request_ID INT NOT NULL,  -- Add NOT NULL here
    Blood_ID INT NOT NULL,     -- Add NOT NULL here
    Delivery_Date DATE,
    Status VARCHAR(50),  -- e.g., 'Delivered', 'Pending'
    FOREIGN KEY (Request_ID) REFERENCES HOSPITAL_BLOOD_REQUESTS(Request_ID),  -- No NOT NULL here
    FOREIGN KEY (Blood_ID) REFERENCES BLOOD(Blood_ID)  -- No NOT NULL here
);


CREATE TABLE PATIENT (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact_Info VARCHAR(100),
    Date_Of_Birth DATE,
    Medical_Records TEXT
);

CREATE TABLE TRANSFUSION_HISTORY (
    Transfusion_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,  -- Add NOT NULL here
    Blood_Delivery_ID INT NOT NULL,  -- Add NOT NULL here
    Hospital_ID INT NOT NULL,  -- Add NOT NULL here
    Transfusion_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID),  -- No NOT NULL here
    FOREIGN KEY (Blood_Delivery_ID) REFERENCES BLOOD_DELIVERY(Delivery_ID),  -- No NOT NULL here
    FOREIGN KEY (Hospital_ID) REFERENCES HOSPITAL(Hospital_ID)  -- No NOT NULL here
);

INSERT INTO DONOR (Donor_ID, Name, Contact_Info, Registration_Date, Eligibility_Status) VALUES
(1, 'Alice Johnson', 'alice.j@example.com', '2023-01-15', 'Eligible'),
(2, 'Bob Smith', 'bob.smith@example.com', '2023-02-20', 'Eligible'),
(3, 'Charlie Brown', 'charlie.b@example.com', '2023-03-10', 'Not Eligible'),
(4, 'Diana Prince', 'diana.p@example.com', '2023-04-05', 'Eligible'),
(5, 'Edward Elric', 'edward.e@example.com', '2023-05-01', 'Eligible'),
(6, 'Fiona Gallagher', 'fiona.g@example.com', '2023-06-15', 'Eligible'),
(7, 'George Weasley', 'george.w@example.com', '2023-07-20', 'Not Eligible'),
(8, 'Hannah Baker', 'hannah.b@example.com', '2023-08-25', 'Eligible'),
(9, 'Isaac Clarke', 'isaac.c@example.com', '2023-09-30', 'Eligible'),
(10, 'Jenna Ortega', 'jenna.o@example.com', '2023-10-10', 'Eligible'),
(11, 'Kevin Hart', 'kevin.h@example.com', '2023-11-15', 'Not Eligible'),
(12, 'Laura Croft', 'laura.c@example.com', '2023-12-20', 'Eligible'),
(13, 'Michael Scott', 'michael.s@example.com', '2023-01-22', 'Eligible'),
(14, 'Nancy Drew', 'nancy.d@example.com', '2023-02-12', 'Eligible'),
(15, 'Oscar Isaac', 'oscar.i@example.com', '2023-03-05', 'Eligible');


INSERT INTO DONOR_HEALTH (Health_Record_ID, Donor_ID, Medical_History, Eligibility_Evaluation, Record_Date) VALUES
(1, 1, 'No significant medical history.', 'Eligible', '2023-01-15'),
(2, 2, 'Recent surgery, not eligible.', 'Not Eligible', '2023-02-20'),
(3, 3, 'Chronic illness, not eligible.', 'Not Eligible', '2023-03-10'),
(4, 4, 'Healthy, eligible.', 'Eligible', '2023-04-05'),
(5, 5, 'No significant medical history.', 'Eligible', '2023-05-01'),
(6, 6, 'Allergies, eligible.', 'Eligible', '2023-06-15'),
(7, 7, 'Medication affecting eligibility.', 'Not Eligible', '2023-07-20'),
(8, 8, 'Healthy, eligible.', 'Eligible', '2023-08-25'),
(9, 9, 'No significant medical history.', 'Eligible', '2023-09-30'),
(10, 10, 'Vaccinated, eligible.', 'Eligible', '2023-10-10'),
(11, 11, 'History of anemia, not eligible.', 'Not Eligible', '2023-11-15'),
(12, 12, 'No significant medical history.', 'Eligible', '2023-12-20'),
(13, 13, 'Healthy, eligible.', 'Eligible', '2023-01-22'),
(14, 14, 'Recent illness, eligible.', 'Eligible', '2023-02-12'),
(15, 15, 'No significant medical history.', 'Eligible', '2023-03-05');

INSERT INTO BLOOD (Blood_ID, Blood_Type, Donation_Date, Expiry_Date, Status) VALUES
(1, 'A+', '2023-01-20', '2023-07-20', 'Available'),
(2, 'O-', '2023-02-25', '2023-08-25', 'Available'),
(3, 'B+', '2023-03-15', '2023-09-15', 'Available'),
(4, 'AB+', '2023-04-10', '2023-10-10', 'Available'),
(5, 'A-', '2023-05-05', '2023-11-05', 'Available'),
(6, 'O+', '2023-06-20', '2023-12-20', 'Available'),
(7, 'B-', '2023-07-25', '2024-01-25', 'Available'),
(8, 'AB-', '2023-08-30', '2024-02-29', 'Available'),
(9, 'A+', '2023-09-15', '2024-03-15', 'Available'),
(10, 'O-', '2023-10-01', '2024-04-01', 'Available'),
(11, 'B+', '2023-11-20', '2024-05-20', 'Available'),
(12, 'AB+', '2023-12-15', '2024-06-15', 'Available'),
(13, 'A-', '2023-01-10', '2023-07-10', 'Available'),
(14, 'O+', '2023-02-05', '2023-08-05', 'Available'),
(15, 'B-', '2023-03-20', '2023-09-20', 'Available');


INSERT INTO DONATION_HISTORY (Donation_History_ID, Donor_ID, Blood_ID, Donation_Date) VALUES
(1, 1, 1, '2023-01-20'),
(2, 2, 2, '2023-02-25'),
(3, 3, 3, '2023-03-15'),
(4, 4, 4, '2023-04-10'),
(5, 5, 5, '2023-05-05'),
(6, 6, 6, '2023-06-20'),
(7, 7, 7, '2023-07-25'),
(8, 8, 8, '2023-08-30'),
(9, 9, 9, '2023-09-15'),
(10, 10, 10, '2023-10-01'),
(11, 11, 11, '2023-11-20'),
(12, 12, 12, '2023-12-15'),
(13, 13, 13, '2023-01-10'),
(14, 14, 14, '2023-02-05'),
(15, 15, 15, '2023-03-20');


INSERT INTO BLOOD_STORAGE (Storage_ID, Location, Capacity) VALUES
(1, 'Central Blood Bank', 500),
(2, 'Northside Clinic', 200),
(3, 'Eastside Hospital', 300),
(4, 'Westside Health Center', 250),
(5, 'City General Hospital', 400);

INSERT INTO BLOOD_INVENTORY (Inventory_ID, Blood_ID, Storage_ID, Quantity) VALUES
(1, 1, 1, 100),
(2, 2, 2, 150),
(3, 3, 3, 200),
(4, 4, 4, 50),
(5, 5, 5, 75),
(6, 6, 1, 60),
(7, 7, 2, 30),
(8, 8, 3, 45),
(9, 9, 4, 80),
(10, 10, 5, 55);

INSERT INTO HOSPITAL (Hospital_ID, Name, Location, Contact_Info) VALUES
(1, 'City Hospital', 'Downtown', '555-0101'),
(2, 'Northside Medical Center', 'Northside', '555-0202'),
(3, 'Eastside Community Hospital', 'Eastside', '555-0303'),
(4, 'Westside General Hospital', 'Westside', '555-0404'),
(5, 'County Hospital', 'Uptown', '555-0505'),
(6, 'South End Community Health Center', 'Boston, MA', '617-555-1111'),
(7, 'Harborview Medical Center', 'South Boston', '617-556-1112'),
(8, 'Boston Children’s Hospital', 'Longwood Medical Area', '617-555-1113'),
(9, 'Brigham and Women’s Hospital', 'Mission Hill', '617-555-1114'),
(10, 'Massachusetts General Hospital', 'West End', '617-555-1115'),
(11, 'Boston Medical Center', 'South End', '617-555-1116'),
(12, 'South End Community Health Center', 'Boston, MA', '617-555-1117');



INSERT INTO HOSPITAL_BLOOD_REQUESTS (Request_ID, Hospital_ID, Blood_Type_Requested, Quantity_Requested, Request_Date) VALUES
(1, 1, 'A+', 10, '2023-01-25'),
(2, 2, 'O-', 5, '2023-02-28'),
(3, 3, 'B+', 8, '2023-03-15'),
(4, 4, 'AB+', 4, '2023-04-12'),
(5, 5, 'A-', 6, '2023-05-20');



INSERT INTO BLOOD_DELIVERY (Delivery_ID, Request_ID, Blood_ID, Delivery_Date, Status) VALUES 
(1, 1, 1, '2024-01-15', 'Delivered'),
(2, 2, 2, '2024-01-16', 'Pending'),
(3, 3, 3, '2024-01-17', 'Delivered');

INSERT INTO PATIENT (Patient_ID, Name, Contact_Info, Date_Of_Birth, Medical_Records) VALUES 
(1, 'John Doe', 'john.doe@example.com', '1980-01-01', 'Allergic to Penicillin'),
(2, 'Jane Smith', 'jane.smith@example.com', '1990-05-05', 'No known allergies');

INSERT INTO TRANSFUSION_HISTORY (Transfusion_ID, Patient_ID, Blood_Delivery_ID, Hospital_ID, Transfusion_Date) VALUES 
(1, 1, 1, 1, '2024-01-16'),
(2, 2, 3, 2, '2024-01-18');


-- See all data from DONOR table
SELECT * FROM DONOR;

-- See all data from DONOR_HEALTH table
SELECT * FROM DONOR_HEALTH;

-- See all data from BLOOD table
SELECT * FROM BLOOD;

-- See all data from DONATION_HISTORY table
SELECT * FROM DONATION_HISTORY;

-- See all data from BLOOD_STORAGE table
SELECT * FROM BLOOD_STORAGE;

-- See all data from BLOOD_INVENTORY table
SELECT * FROM BLOOD_INVENTORY;

-- See all data from HOSPITAL table
SELECT * FROM HOSPITAL;

-- See all data from HOSPITAL_BLOOD_REQUESTS table
SELECT * FROM HOSPITAL_BLOOD_REQUESTS;

-- See all data from BLOOD_DELIVERY table
SELECT * FROM BLOOD_DELIVERY;

-- See all data from PATIENT table
SELECT * FROM PATIENT;

-- See all data from TRANSFUSION_HISTORY table
SELECT * FROM TRANSFUSION_HISTORY;

DELETE FROM HOSPITAL WHERE Hospital_ID = 10; -- Change 11 to the specific ID you want to delete
