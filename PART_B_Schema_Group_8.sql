set echo on;
SPOOL "MonashDronesSchema.txt";

-- Generated by Oracle SQL Developer Data Modeler 18.2.0.179.0806
--   at:        2019-04-25 12:29:43 AEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g


--Anisha Shrestha :29389356
--Nayanatara Samarasekera: 28302753

--Adding drop sequences 

DROP SEQUENCE cust_id_sequence;

DROP SEQUENCE drone_id_sequence;

DROP SEQUENCE emp_id_sequence;

DROP SEQUENCE loan_id_sequence;

DROP SEQUENCE order_id_sequence;

DROP SEQUENCE pay_id_sequence;

DROP SEQUENCE supplier_id_sequence;

DROP SEQUENCE training_id_sequence;


DROP TABLE business CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE drone CASCADE CONSTRAINTS;

DROP TABLE drone_for_rent CASCADE CONSTRAINTS;

DROP TABLE drone_for_sale CASCADE CONSTRAINTS;

DROP TABLE employee CASCADE CONSTRAINTS;

DROP TABLE individual CASCADE CONSTRAINTS;

DROP TABLE loan CASCADE CONSTRAINTS;

DROP TABLE loan_line CASCADE CONSTRAINTS;

DROP TABLE order_line CASCADE CONSTRAINTS;

DROP TABLE orders CASCADE CONSTRAINTS;

DROP TABLE payment_instalment CASCADE CONSTRAINTS;

DROP TABLE supplier CASCADE CONSTRAINTS;

DROP TABLE training_activity CASCADE CONSTRAINTS;

CREATE TABLE business (
    cust_id       NUMBER(7) NOT NULL,
    cust_abm_no   NUMBER(10) NOT NULL,
    cust_fax_no   CHAR(11) NOT NULL
);

COMMENT ON COLUMN business.cust_id IS
    'unique identifier for a customer.';

COMMENT ON COLUMN business.cust_abm_no IS
    'ABM number of the customer';

COMMENT ON COLUMN business.cust_fax_no IS
    'Fax number of a customer. ';

ALTER TABLE business ADD CONSTRAINT business_pk PRIMARY KEY ( cust_id );

CREATE TABLE customer (
    cust_id           NUMBER(7) NOT NULL,
    cust_address      VARCHAR2(150) NOT NULL,
    cust_email        VARCHAR2(50) NOT NULL,
    cust_contact_no   CHAR(10) NOT NULL,
    cust_type         CHAR(1) NOT NULL
);

ALTER TABLE customer
    ADD CONSTRAINT cust_type_constraints CHECK ( cust_type IN (
        'B',
        'I'
    ) );

COMMENT ON COLUMN customer.cust_id IS
    'unique identifier for a customer.';

COMMENT ON COLUMN customer.cust_address IS
    'The address of the customer.';

COMMENT ON COLUMN customer.cust_email IS
    'Email address of a customer.';

COMMENT ON COLUMN customer.cust_contact_no IS
    'Mobile number of a customer.';

COMMENT ON COLUMN customer.cust_type IS
    'Cutomer type - Individual or Bussiness, I/B respectively. ';

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_id );

CREATE TABLE drone (
    drone_id           NUMBER(7) NOT NULL,
    platform           VARCHAR2(50) NOT NULL,
    range              NUMBER(7,2) NOT NULL,
    manufacture_date   DATE NOT NULL,
    rpl_required       CHAR(1) NOT NULL,
    drone_for_rent     CHAR(1) NOT NULL,
    drone_for_sale     CHAR(1) NOT NULL,
    supplier_id        NUMBER NOT NULL
);

ALTER TABLE drone
    ADD CONSTRAINT rpl_required_constraint CHECK ( rpl_required IN (
        'N',
        'Y'
    ) );

ALTER TABLE drone
    ADD CONSTRAINT drone_for_rent_constraint CHECK ( drone_for_rent IN (
        'N',
        'Y'
    ) );

ALTER TABLE drone
    ADD CONSTRAINT drone_for_sale_constraing CHECK ( drone_for_sale IN (
        'N',
        'Y'
    ) );

COMMENT ON COLUMN drone.drone_id IS
    'Drone ID idetifies a unique drone.';

COMMENT ON COLUMN drone.platform IS
    'platform used by the drones. ';

COMMENT ON COLUMN drone.range IS
    'Range is the flying distance capacity of a dorne in meters. ';

COMMENT ON COLUMN drone.manufacture_date IS
    'Manufacture date of the drone. ';

COMMENT ON COLUMN drone.rpl_required IS
    'If Remote Pilot Licence (RPL) is required for the drone (Y/S).';

COMMENT ON COLUMN drone.drone_for_rent IS
    'If the drone is for rent (Y/N)';

COMMENT ON COLUMN drone.drone_for_sale IS
    'If the drone is for sale (Y/N).';

COMMENT ON COLUMN drone.supplier_id IS
    'Supplier''s ID';

ALTER TABLE drone ADD CONSTRAINT drone_pk PRIMARY KEY ( drone_id );

CREATE TABLE drone_for_rent (
    drone_id            NUMBER(7) NOT NULL,
    rental_hour_rate    NUMBER(7,2) NOT NULL,
    late_penalty_rate   NUMBER(7,2) NOT NULL
);

COMMENT ON COLUMN drone_for_rent.drone_id IS
    'Drone ID idetifies a unique drone.';

COMMENT ON COLUMN drone_for_rent.rental_hour_rate IS
    'Rental hourly rate for a drone';

COMMENT ON COLUMN drone_for_rent.late_penalty_rate IS
    'Late penalty rate is charged to customers when they return the drone after the expected date and return time. '
    ;

ALTER TABLE drone_for_rent ADD CONSTRAINT drone_for_rent_pk PRIMARY KEY ( drone_id
);

CREATE TABLE drone_for_sale (
    drone_id          NUMBER(7) NOT NULL,
    warranty_period   NUMBER(1) NOT NULL,
    selling_price     NUMBER(7,2) NOT NULL
);

ALTER TABLE drone_for_sale
    ADD CONSTRAINT warranty_period_constraint CHECK ( warranty_period BETWEEN 1 AND
    5 );

COMMENT ON COLUMN drone_for_sale.drone_id IS
    'Drone ID idetifies a unique drone.';

COMMENT ON COLUMN drone_for_sale.warranty_period IS
    'waranty period in years. between 1 to 5 years. ';

COMMENT ON COLUMN drone_for_sale.selling_price IS
    'The price of the drone.';

ALTER TABLE drone_for_sale ADD CONSTRAINT drone_for_sale_pk PRIMARY KEY ( drone_id
);

CREATE TABLE employee (
    emp_id           NUMBER(7) NOT NULL,
    emp_dob          DATE NOT NULL,
    emp_address      VARCHAR2(50) NOT NULL,
    rpl_no           NUMBER(7),
    emp_contact_no   CHAR(10) NOT NULL
);

COMMENT ON COLUMN employee.emp_id IS
    'Unique identifier for each employee.';

COMMENT ON COLUMN employee.emp_dob IS
    'Date of birth of employees. ';

COMMENT ON COLUMN employee.emp_address IS
    'Employee''s address';

COMMENT ON COLUMN employee.rpl_no IS
    'Remote pilot license number(not mandatory for all employees)';

COMMENT ON COLUMN employee.emp_contact_no IS
    'mobile contact no. of employees.';

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( emp_id );

CREATE TABLE individual (
    cust_id          NUMBER(7) NOT NULL,
    cust_gender      CHAR(1) NOT NULL,
    cust_age_range   NUMBER(3) NOT NULL
);

ALTER TABLE individual
    ADD CONSTRAINT cust_gender_constraint CHECK ( cust_gender IN (
        'F',
        'M'
    ) );

ALTER TABLE individual
    ADD CONSTRAINT cust_age_range_constraint CHECK ( cust_age_range BETWEEN 18 AND
    24
                                                     OR cust_age_range BETWEEN 25
                                                     AND 34
                                                     OR cust_age_range BETWEEN 35
                                                     AND 44
                                                     OR cust_age_range BETWEEN 45
                                                     AND 60
                                                     OR cust_age_range BETWEEN 61
                                                     AND 80
                                                     OR cust_age_range BETWEEN 81
                                                     AND 100 );

COMMENT ON COLUMN individual.cust_id IS
    'unique identifier for a customer.';

COMMENT ON COLUMN individual.cust_gender IS
    'Gender - M/F';

COMMENT ON COLUMN individual.cust_age_range IS
    'Age range of customer';

ALTER TABLE individual ADD CONSTRAINT individual_pk PRIMARY KEY ( cust_id );

CREATE TABLE loan (
    loan_id          NUMBER(7) NOT NULL,
    loan_date_time   DATE NOT NULL,
    due_date_time    DATE NOT NULL,
    cust_id          NUMBER(7) NOT NULL
);

COMMENT ON COLUMN loan.loan_id IS
    'LOAN ID is unique to every loan they place.. ';

COMMENT ON COLUMN loan.loan_date_time IS
    'The date and time of the loan placed.';

COMMENT ON COLUMN loan.due_date_time IS
    'The due to return the drones rented.';

COMMENT ON COLUMN loan.cust_id IS
    'unique identifier for a customer.';

ALTER TABLE loan ADD CONSTRAINT loan_pk PRIMARY KEY ( loan_id );

CREATE TABLE loan_line (
    loan_id    NUMBER(7) NOT NULL,
    drone_id   NUMBER(7) NOT NULL
);

COMMENT ON COLUMN loan_line.loan_id IS
    'LOAN ID is unique to every loan they place.. ';

COMMENT ON COLUMN loan_line.drone_id IS
    'Drone ID idetifies a unique drone.';

ALTER TABLE loan_line ADD CONSTRAINT loan_line_pk PRIMARY KEY ( drone_id,
                                                                loan_id );

CREATE TABLE order_line (
    order_id   NUMBER(7) NOT NULL,
    drone_id   NUMBER(7) NOT NULL
);

COMMENT ON COLUMN order_line.order_id IS
    'Order ID is unique for every order a customer makes. ';

COMMENT ON COLUMN order_line.drone_id IS
    'Drone ID idetifies a unique drone.';

ALTER TABLE order_line ADD CONSTRAINT order_line_pk PRIMARY KEY ( order_id,
                                                                  drone_id );

CREATE TABLE orders (
    order_id        NUMBER(7) NOT NULL,
    order_date      DATE NOT NULL,
    order_balance   NUMBER(7,2) NOT NULL,
    cust_id         NUMBER(7) NOT NULL
);

COMMENT ON COLUMN orders.order_id IS
    'Order ID is unique for every order a customer makes. ';

COMMENT ON COLUMN orders.order_date IS
    'The date when the order was made. ';

COMMENT ON COLUMN orders.order_balance IS
    'The total cost of the order.';

COMMENT ON COLUMN orders.cust_id IS
    'unique identifier for a customer.';

ALTER TABLE orders ADD CONSTRAINT order_pk PRIMARY KEY ( order_id );

CREATE TABLE payment_instalment (
    pay_id            NUMBER(7) NOT NULL,
    pay_amount        NUMBER(5,2) NOT NULL,
    pay_description   VARCHAR2(100) NOT NULL,
    order_id          NUMBER(7),
    loan_id           NUMBER(7)
);

COMMENT ON COLUMN payment_instalment.pay_id IS
    'The pay_id is unique each  instalment payment made for a particular order or loan.'
    ;

COMMENT ON COLUMN payment_instalment.pay_amount IS
    'The payment made for every instalment. ';

COMMENT ON COLUMN payment_instalment.pay_description IS
    'description to identify each instalment.';

COMMENT ON COLUMN payment_instalment.order_id IS
    'Order ID is unique for every order a customer makes. ';

COMMENT ON COLUMN payment_instalment.loan_id IS
    'LOAN ID is unique to every loan they place.. ';

ALTER TABLE payment_instalment ADD CONSTRAINT payment_instalment_pk PRIMARY KEY (
pay_id );

CREATE TABLE supplier (
    supplier_id   NUMBER NOT NULL,
    contact_no    CHAR(10) NOT NULL,
    address       VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN supplier.supplier_id IS
    'Supplier''s ID';

COMMENT ON COLUMN supplier.contact_no IS
    'Supplier contact number.';

COMMENT ON COLUMN supplier.address IS
    'Supplier''s Address';

ALTER TABLE supplier ADD CONSTRAINT supplier_pk PRIMARY KEY ( supplier_id );

ALTER TABLE supplier ADD CONSTRAINT nk_supplier UNIQUE ( contact_no );

CREATE TABLE training_activity (
    training_id            NUMBER(7) NOT NULL,
    emp_id                 NUMBER(7) NOT NULL,
    cust_id                NUMBER(7) NOT NULL,
    training_date_time     DATE NOT NULL,
    drone_id               NUMBER(7) NOT NULL,
    training_duration      NUMBER(5,2) NOT NULL,
    special_instructions   VARCHAR2(150)
);

COMMENT ON COLUMN training_activity.training_id IS
    'Surrogate key for training activity.';

COMMENT ON COLUMN training_activity.emp_id IS
    'Unique identifier for each employee.';

COMMENT ON COLUMN training_activity.cust_id IS
    'unique identifier for a customer.';

COMMENT ON COLUMN training_activity.training_date_time IS
    'Date and time the activity takes place.';

COMMENT ON COLUMN training_activity.drone_id IS
    'Drone ID idetifies a unique drone.';

COMMENT ON COLUMN training_activity.training_duration IS
    'Duration of the activities in hours. ';

COMMENT ON COLUMN training_activity.special_instructions IS
    'Employees may complete special tasks while conducting the training. ';

ALTER TABLE training_activity ADD CONSTRAINT trainig_activity_pk PRIMARY KEY ( training_id
);

ALTER TABLE training_activity
    ADD CONSTRAINT nk_training_activity UNIQUE ( emp_id,
                                                 cust_id,
                                                 training_date_time );

ALTER TABLE loan
    ADD CONSTRAINT customer_makes_loan FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE orders
    ADD CONSTRAINT customer_makes_order FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE training_activity
    ADD CONSTRAINT customer_requests_training FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE loan_line
    ADD CONSTRAINT drone_has_loan_line FOREIGN KEY ( drone_id )
        REFERENCES drone_for_rent ( drone_id );

ALTER TABLE order_line
    ADD CONSTRAINT drone_has_order_line FOREIGN KEY ( drone_id )
        REFERENCES drone_for_sale ( drone_id );

ALTER TABLE training_activity
    ADD CONSTRAINT drone_used_for_training FOREIGN KEY ( drone_id )
        REFERENCES drone ( drone_id );

ALTER TABLE training_activity
    ADD CONSTRAINT employee_carries_out_training FOREIGN KEY ( emp_id )
        REFERENCES employee ( emp_id );

ALTER TABLE business
    ADD CONSTRAINT fk_business_customer FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE drone_for_rent
    ADD CONSTRAINT fk_drone_drone_for_rent FOREIGN KEY ( drone_id )
        REFERENCES drone ( drone_id );

ALTER TABLE drone_for_sale
    ADD CONSTRAINT fk_drone_dront_for_sale FOREIGN KEY ( drone_id )
        REFERENCES drone ( drone_id );

ALTER TABLE individual
    ADD CONSTRAINT fk_individual_customer FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE loan_line
    ADD CONSTRAINT loan_has_loan_line FOREIGN KEY ( loan_id )
        REFERENCES loan ( loan_id );

ALTER TABLE payment_instalment
    ADD CONSTRAINT loan_has_payment_instament FOREIGN KEY ( loan_id )
        REFERENCES loan ( loan_id );

ALTER TABLE order_line
    ADD CONSTRAINT order_has_order_line FOREIGN KEY ( order_id )
        REFERENCES orders ( order_id );

ALTER TABLE payment_instalment
    ADD CONSTRAINT order_has_payment_instalment FOREIGN KEY ( order_id )
        REFERENCES orders ( order_id );

ALTER TABLE drone
    ADD CONSTRAINT supplier_supplies_drone FOREIGN KEY ( supplier_id )
        REFERENCES supplier ( supplier_id );

CREATE OR REPLACE TRIGGER arc_fk_customer_sub_individual BEFORE
    INSERT OR UPDATE OF cust_id ON individual
    FOR EACH ROW
DECLARE
    d   CHAR(1);
BEGIN
    SELECT
        a.cust_type
    INTO d
    FROM
        customer a
    WHERE
        a.cust_id =:new.cust_id;

    IF ( d IS NULL OR d <> 'I' ) THEN
        raise_application_error(-20223,'FK FK_INDIVIDUAL_CUSTOMER in Table INDIVIDUAL violates Arc constraint on Table CUSTOMER - discriminator column cust_type doesn''t have value ''I'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fk_customer_subty_business BEFORE
    INSERT OR UPDATE OF cust_id ON business
    FOR EACH ROW
DECLARE
    d   CHAR(1);
BEGIN
    SELECT
        a.cust_type
    INTO d
    FROM
        customer a
    WHERE
        a.cust_id =:new.cust_id;

    IF ( d IS NULL OR d <> 'B' ) THEN
        raise_application_error(-20223,'FK FK_BUSINESS_CUSTOMER in Table BUSINESS violates Arc constraint on Table CUSTOMER - discriminator column cust_type doesn''t have value ''B'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE cust_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE drone_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE emp_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE loan_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE order_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE pay_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE supplier_id_sequence START WITH 100 NOCACHE ORDER;

CREATE SEQUENCE training_id_sequence START WITH 100 NOCACHE ORDER;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          8
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

spool off;
set echo off;