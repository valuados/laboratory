CREATE DATABASE IF NOT EXISTS NC_LABORATORY;
USE NC_LABORATORY;

SET FOREIGN_KEY_CHECKS=0;



DROP TABLE IF EXISTS T_CATEGORY CASCADE;
DROP TABLE IF EXISTS T_CHARACTERISTIC_COMPONENT CASCADE;
DROP TABLE IF EXISTS T_CHARACTERISTIC_CONTAINER CASCADE;
DROP TABLE IF EXISTS T_CHARACTERISTIC_ITEM CASCADE;
DROP TABLE IF EXISTS T_COMPONENT CASCADE;
DROP TABLE IF EXISTS T_OFFER CASCADE;
DROP TABLE IF EXISTS T_OFFER_COMP_M2M_CH_CONT CASCADE;
DROP TABLE IF EXISTS T_ORDER CASCADE;
DROP TABLE IF EXISTS T_ORDER_COMPONENT CASCADE;
DROP TABLE IF EXISTS T_SALES_ORDER CASCADE;

CREATE TABLE T_CATEGORY
(
	F_CATEGORY_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_CATEGORY_NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY (F_CATEGORY_ID)

) ;


CREATE TABLE T_CHARACTERISTIC_COMPONENT
(
	F_CH_COMPONENT_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_CH_CONTAINER_ID INTEGER,
	F_CH_COMPONENT_VALUE VARCHAR(100) NOT NULL,
	PRIMARY KEY (F_CH_COMPONENT_ID),
	KEY (F_CH_CONTAINER_ID)

) ;


CREATE TABLE T_CHARACTERISTIC_CONTAINER
(
	F_CH_CONTAINER_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_CH_CONTAINER_NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY (F_CH_CONTAINER_ID)

) ;


CREATE TABLE T_CHARACTERISTIC_ITEM
(
	F_CH_ITEM_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_CH_CONTAINER_ID INTEGER NOT NULL,
	F_CH_COMPONENT_ID INTEGER NOT NULL,
	F_ORDER_COMPONENT_ID INTEGER NOT NULL,
	PRIMARY KEY (F_CH_ITEM_ID),
	KEY (F_CH_COMPONENT_ID),
	KEY (F_CH_CONTAINER_ID),
	KEY (F_ORDER_COMPONENT_ID)

) ;


CREATE TABLE T_COMPONENT
(
	F_COMPONENT_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_OFFER_ID INTEGER NOT NULL,
	F_COMPONENT_NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY (F_COMPONENT_ID),
	KEY (F_OFFER_ID)

) ;


CREATE TABLE T_OFFER
(
	F_OFFER_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_CATEGORY_ID INTEGER NOT NULL,
	F_OFFER_NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY (F_OFFER_ID),
	KEY (F_CATEGORY_ID)

) ;


CREATE TABLE T_OFFER_COMP_M2M_CH_CONT
(
	F_OFFER_ID INTEGER,
	F_COMPONENT_ID INTEGER,
	F_CH_CONTAINER_ID INTEGER,
	KEY (F_OFFER_ID),
	KEY (F_CH_CONTAINER_ID),
	KEY (F_COMPONENT_ID)

) ;


CREATE TABLE T_ORDER
(
	F_ORDER_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_OFFER_ID INTEGER NOT NULL,
	F_SALES_ORDER_ID INTEGER NOT NULL,
	PRIMARY KEY (F_ORDER_ID),
	KEY (F_OFFER_ID),
	KEY (F_SALES_ORDER_ID)

) ;


CREATE TABLE T_ORDER_COMPONENT
(
	F_ORDER_COMPONENT_ID INTEGER NOT NULL AUTO_INCREMENT,
	F_COMPONENT_ID INTEGER NOT NULL,
	F_ORDER_ID INTEGER NOT NULL,
	PRIMARY KEY (F_ORDER_COMPONENT_ID),
	KEY (F_COMPONENT_ID),
	KEY (F_ORDER_ID)

) ;


CREATE TABLE T_SALES_ORDER
(
	F_SALES_ORDER_ID INTEGER NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (F_SALES_ORDER_ID)

) ;



SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE T_CHARACTERISTIC_COMPONENT ADD CONSTRAINT FK_CH_COMPONENT_CH_CONTAINER
FOREIGN KEY (F_CH_CONTAINER_ID) REFERENCES T_CHARACTERISTIC_CONTAINER (F_CH_CONTAINER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_CHARACTERISTIC_ITEM ADD CONSTRAINT FK_CH_ITEM_CH_COMPONENT
FOREIGN KEY (F_CH_COMPONENT_ID) REFERENCES T_CHARACTERISTIC_COMPONENT (F_CH_COMPONENT_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_CHARACTERISTIC_ITEM ADD CONSTRAINT FK_CH_ITEM_CH_CONTAINER
FOREIGN KEY (F_CH_CONTAINER_ID) REFERENCES T_CHARACTERISTIC_CONTAINER (F_CH_CONTAINER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_CHARACTERISTIC_ITEM ADD CONSTRAINT FK_CH_ITEM_ORDER_COMPONENT
FOREIGN KEY (F_ORDER_COMPONENT_ID) REFERENCES T_ORDER_COMPONENT (F_ORDER_COMPONENT_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_COMPONENT ADD CONSTRAINT FK_COMPONENT_OFFER
FOREIGN KEY (F_OFFER_ID) REFERENCES T_OFFER (F_OFFER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_OFFER ADD CONSTRAINT FK_OFFER_CATEGORY
FOREIGN KEY (F_CATEGORY_ID) REFERENCES T_CATEGORY (F_CATEGORY_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_OFFER_COMP_M2M_CH_CONT ADD CONSTRAINT FK_M_CH_OFFER
FOREIGN KEY (F_OFFER_ID) REFERENCES T_OFFER (F_OFFER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_OFFER_COMP_M2M_CH_CONT ADD CONSTRAINT FK_CH_CONTAINER_M
FOREIGN KEY (F_CH_CONTAINER_ID) REFERENCES T_CHARACTERISTIC_CONTAINER (F_CH_CONTAINER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_OFFER_COMP_M2M_CH_CONT ADD CONSTRAINT FK_COMP_M
FOREIGN KEY (F_COMPONENT_ID) REFERENCES T_COMPONENT (F_COMPONENT_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_ORDER ADD CONSTRAINT FK_ORDER_OFFER
FOREIGN KEY (F_OFFER_ID) REFERENCES T_OFFER (F_OFFER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_ORDER ADD CONSTRAINT FK_ORDER_SALES_ORDER
FOREIGN KEY (F_SALES_ORDER_ID) REFERENCES T_SALES_ORDER (F_SALES_ORDER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_ORDER_COMPONENT ADD CONSTRAINT FK_ORDER_COMPONENT_COMPONENT
FOREIGN KEY (F_COMPONENT_ID) REFERENCES T_COMPONENT (F_COMPONENT_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE T_ORDER_COMPONENT ADD CONSTRAINT FK_ORDER_COMPONENT_ORDER
FOREIGN KEY (F_ORDER_ID) REFERENCES T_ORDER (F_ORDER_ID)
	ON DELETE CASCADE ON UPDATE CASCADE;