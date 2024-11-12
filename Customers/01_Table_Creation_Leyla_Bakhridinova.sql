create table if not exists star.factcustomersales
(
    factcustomersalesid  serial primary key,
    dateid               int references star.dimdate (dateid),
    customerid           varchar(5) references star.dimcustomer (customerid),
    totalamount          decimal(10, 2),
    totalquantity        int,
    numberoftransactions int
);
