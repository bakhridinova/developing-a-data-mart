create table if not exists star.factproductsales
(
    factsalesid  serial primary key,
    dateid       int references star.dimdate (dateid),
    productid    int references star.dimproduct (productid),
    quantitysold int,
    totalsales   numeric(10, 2)
);
