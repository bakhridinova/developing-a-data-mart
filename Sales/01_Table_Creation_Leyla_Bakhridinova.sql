create table if not exists star.factsales
(
    factsalesid  serial primary key,
    dateid       int references star.dimdate (dateid),
    customerid   varchar(5) references star.dimcustomer (customerid),
    productid    int references star.dimproduct (productid),
    employeeid   int references star.dimemployee (employeeid),
    categoryid   int references star.dimcategory (categoryid),
    shipperid    int references star.dimshipper (shipperid),
    supplierid   int references star.dimsupplier (supplierid),
    quantitysold int,
    unitprice    decimal(10, 2),
    discount     decimal(10, 2),
    totalamount  decimal(10, 2) generated always as (quantitysold * unitprice - discount) stored,
    taxamount    decimal(10, 2),
    foreign key (dateid) references star.dimdate (dateid),
    foreign key (customerid) references star.dimcustomer (customerid),
    foreign key (productid) references star.dimproduct (productid),
    foreign key (employeeid) references star.dimemployee (employeeid),
    foreign key (categoryid) references star.dimcategory (categoryid),
    foreign key (shipperid) references star.dimshipper (shipperid),
    foreign key (supplierid) references star.dimsupplier (supplierid)
);
