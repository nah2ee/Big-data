CREATE DATABASE banapresso;

USE banapresso;

CREATE TABLE tb_store (
	sto_idx bigint auto_increment primary key,
    sto_name varchar(20) not null,
    sto_address varchar(50) not null
);

SELECT * FROM tb_store;
DROP TABLE tb_store;

INSERT INTO tb_store(sto_name, sto_address) VALUES ("사과점", "서울시 강남구"); -- 테스트 구문
