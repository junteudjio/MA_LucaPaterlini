create table product
(
product_id number primary key,
name varchar2(128 byte) not null,
rrp number not null,
available_from date not null
);

create table orders
(
order_id number primary key,
product_id number not null,
quantity number not null,
order_price number not null,
dispatch_date date not null,
foreign key (product_id) references product(product_id)
);

-- Write an sql query to find books that have sold fewer than 10 copies in the last year, excluding books that have been available for
-- less than 1 month. (1 month is really generic I have set 30 days instead

-- Solution 1: Do not consider those that have 0 sales
select product.name
from product,orders
where orders.product_id =product.product_id AND
    (sysdate -available_from) > 30 AND
      SUM(CASE WHEN sysdate-dispatch_date <365 THEN quantity ELSE 0 END)<10;

-- Solution 2: Includes the 0 sales as well
select product.name
from product right join orders ON orders.product_id =product.product_id
WHERE (sysdate -available_from) > 30 AND
      SUM(CASE WHEN sysdate-dispatch_date <365 THEN quantity ELSE 0 END)<10;







-- Insert queries for testing https://livesql.oracle.com/apex

  INSERT INTO product(product_id,name,rrp,available_from)
  VALUES (101,'Bayesian Methods for Nonlinear Classification and Regression', 94.95, TO_DATE('7/3/2019', 'DD/MM/YYYY'));
  INSERT INTO product(product_id,name,rrp,available_from)
  VALUES (102,'(next year) in Review (preorder)', 21.95,TO_DATE('7/3/2020', 'DD/MM/YYYY'));
  INSERT INTO product(product_id,name,rrp,available_from)
  VALUES (103, 'Learn Python in Ten Minutes', 2.15,TO_DATE('7/1/2019', 'DD/MM/YYYY'));
  INSERT INTO product(product_id,name,rrp,available_from)
  VALUES (104,'sports almanac (1999-2049)', 3.38,TO_DATE('7/1/2017', 'DD/MM/YYYY'));
  INSERT INTO product(product_id,name,rrp,available_from)
  VALUES (105, 'finance for dummies', 84.99,TO_DATE('7/1/2018', 'DD/MM/YYYY'));


INSERT INTO orders(order_id, product_id, quantity, order_price, dispatch_date)
 VALUES (1000,101,1,90.00,TO_DATE('9/1/2018', 'DD/MM/YYYY'));

INSERT INTO orders(order_id, product_id, quantity, order_price, dispatch_date)
 VALUES (1001,103,1,1.15,TO_DATE('27/1/2018', 'DD/MM/YYYY'));

INSERT INTO orders(order_id, product_id, quantity, order_price, dispatch_date)
 VALUES (1002,101,10,90.00,TO_DATE('9/4/2019', 'DD/MM/YYYY'));

INSERT INTO orders(order_id, product_id, quantity, order_price, dispatch_date)
 VALUES (1003,104,11,3.38,TO_DATE('9/9/2018', 'DD/MM/YYYY'));

INSERT INTO orders(order_id, product_id, quantity, order_price, dispatch_date)
 VALUES (1004,105,11,501.33,TO_DATE('9/9/2017', 'DD/MM/YYYY'));
