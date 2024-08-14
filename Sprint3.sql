-- Dropando as tabelas caso forem existentes
DROP TABLE FEEDBACK;
DROP TABLE COMPANY;
DROP TABLE customer;
DROP TABLE frases;
DROP TABLE dicionario_sentimentos;

-- Dropando as sequences caso forem existentes
DROP SEQUENCE seq_feedback;
DROP SEQUENCE seq_company;
DROP SEQUENCE seq_customer;


-- 1. Criando a tabela Customer
CREATE TABLE customer (
    id_customer     INTEGER NOT NULL,
    name            VARCHAR2(60) NOT NULL,
    registration_dt DATE NOT NULL,
    is_satisfied    CHAR(1),
    aged            CHAR(1),
    time_of_service INTEGER NOT NULL,
    exit_forecast   DATE
);

-- 2. Adicionando a chave primária
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( id_customer );

-- 3. Criando a sequence e os 5 registros da tabela "User"
CREATE SEQUENCE seq_customer
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;



INSERT INTO customer (id_customer, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_customer.nextval, 'André', '01-01-2022', 0, 0, 18, '01-04-2023');
INSERT INTO customer (id_customer, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_customer.nextval, 'Eduardo', '04-03-1990', 1, 1, 45, '08-10-2028');
INSERT INTO customer (id_customer, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_customer.nextval, 'Felipe', '08-09-1985', 0, 1, 45, '02-12-2025');
INSERT INTO customer (id_customer, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_customer.nextval, 'Guilherme', '05-11-2015', 1, 1, 45, '10-08-2024');
INSERT INTO customer (id_customer, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_customer.nextval, 'Matheus', '03-04-2023', 1, 1, 45, '04-01-2028');



-- 4. Criando a tabela company
CREATE TABLE company (
    id_company              INTEGER NOT NULL,
    nm_company              VARCHAR2(70) NOT NULL,
    registration_dt_company DATE,
    num_feedbacks_company   INTEGER NOT NULL,
    branch                  VARCHAR2(15) NOT NULL
);

-- 5. Adicionando a chave primária
ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( id_company );


-- 6. Criando a sequence e inserindo 5 registros nessa tabela
CREATE SEQUENCE seq_company
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;

INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Microsoft', '08-09-1985', 2, 'Omni CRM');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Amazon', '17-01-1990', 1, 'Trade');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Apple', '25-04-1983', 1, 'Omni CRM');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Samsung', '10-10-1986', 2, 'AI');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Xiaomi', '05-11-2001', 0, 'Mkt Suite');



-- 7. Criando a tabela feedback
CREATE TABLE feedback (
    id_feedback          INTEGER NOT NULL,
    nm_customer          VARCHAR2(50) NOT NULL,
    feeling              VARCHAR2(20) NOT NULL,
    dt_feedback          DATE,
    company              VARCHAR2(70) NOT NULL,
    customer_id_customer INTEGER NOT NULL,
    company_id_company   INTEGER NOT NULL
);

-- 8. Adicionando a chave primária
ALTER TABLE feedback ADD CONSTRAINT feedback_pk PRIMARY KEY ( id_feedback );

-- 9. Adicionando as duas chaves estrangeiras
ALTER TABLE feedback
    ADD CONSTRAINT feedback_company_fk FOREIGN KEY ( company_id_company )
        REFERENCES company ( id_company );

ALTER TABLE feedback
    ADD CONSTRAINT feedback_customer_fk FOREIGN KEY ( customer_id_customer )
        REFERENCES customer ( id_customer );
        
        
-- 10. Criando a sequence e inserindo 5 registros na tabela feedback
CREATE SEQUENCE seq_feedback
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;

INSERT INTO feedback (id_feedback, nm_customer, feeling, dt_feedback, company, customer_id_customer, company_id_company) VALUES (seq_feedback.nextval, 'André', 'Terrible', '15-03-2022', 'Microsoft', 1, 1);
INSERT INTO feedback (id_feedback, nm_customer, feeling, dt_feedback, company, customer_id_customer, company_id_company) VALUES (seq_feedback.nextval, 'Eduardo', 'Good', '07-09-1996', 'Amazon', 2, 2);
INSERT INTO feedback (id_feedback, nm_customer, feeling, dt_feedback, company, customer_id_customer, company_id_company) VALUES (seq_feedback.nextval, 'Felipe', 'Awesome', '09-09-2015', 'Apple', 3, 3);
INSERT INTO feedback (id_feedback, nm_customer, feeling, dt_feedback, company, customer_id_customer, company_id_company) VALUES (seq_feedback.nextval, 'Guilherme', 'Regular', '12-06-2023', 'Samsung', 4, 4);
INSERT INTO feedback (id_feedback, nm_customer, feeling, dt_feedback, company, customer_id_customer, company_id_company) VALUES (seq_feedback.nextval, 'Matheus', 'Awesome', '03-02-2024', 'Samsung', 5, 4);

-- 11. Criação de um dicionário que armazena sentimentos
CREATE TABLE dicionario_sentimentos (
    id_sentimento   NUMBER PRIMARY KEY,
    palavra_chave   VARCHAR2(100),
    peso            NUMBER -- Peso 1 para sentimento positivo e -1 para sentimento negativo
);

-- Criando a sequence e inserindo 5 registros na tabela dicionario_sentimentos
CREATE SEQUENCE seq_dicionario
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;
    
    
-- 12. Inserir alguns dados no dicionário de sentimentos
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'pessimo', -1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'ruim', -1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'medio', 1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'bom', 1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'excelente', 1);


-- 13. Criar uma tabela para armazenar as frases a serem analisadas
CREATE TABLE frases (
    id_frase    NUMBER PRIMARY KEY,
    frase       VARCHAR2(500)
);


-- Criando a sequence e inserindo 5 registros na tabela frases
CREATE SEQUENCE seq_frases
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;


-- 14. Inserir algumas frases na tabela de frases
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi muito bom e rápido.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'A comida estava ruim e o atendimento foi péssimo.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi mediano, nada a acrescentar.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi péssimo.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi excelente, estão de parabéns.');


-- 1ª Procedure: Seleciona duas tabelas usando o Join e exibe os dados em JSON
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE relatorio_feedbacks
IS BEGIN
    -- Pegando os dados
    SELECT a.name, b.feeling
    FROM customer a
    LEFT JOIN feedback b
    ON a.id_customer = b.customer_id_customer;
    
    -- Print JSON
    DBMS_OUTPUT.PUT_LINE(transform_json(
        p_id => a.id_customer,
        p_nome => a.name,
        p_feeling => b.feeling
    ));
END relatorio_feedbacks;
/




-- 1ª Função: Transformar dados exibidos em JSON
CREATE OR REPLACE FUNCTION transform_json (
    p_id        IN INTEGER, 
    p_nome      IN VARCHAR2,
    p_feeling   IN VARCHAR2
) RETURN CLOB IS 
    v_json CLOB;
BEGIN
    v_json := '{' ||
                ' "id": ' || p_id || ', ' ||
                '"nome": "' || p_nome || '", ' ||
                '"feeling": "' || p_feeling || '" ' ||
                '}';
    
    RETURN v_json;
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('O Tipo de dado inserido é inválido. Tente novamente');
    WHEN LOGIN_DENIED THEN
        DBMS_OUTPUT.PUT_LINE('O usuário ou senha estão inválidos.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('O código PL/SQL tem um problema interno.');
END transform_json;
/

-- Executando e exibindo a função transform_json
SET SERVEROUTPUT ON;

DECLARE
    v_json CLOB;
BEGIN
    v_json := transform_json(
        p_id => 1,
        p_nome => 2,
        p_feeling => 'Awesome'
    );
    dbms_output.put_line(v_json);
END;
/
