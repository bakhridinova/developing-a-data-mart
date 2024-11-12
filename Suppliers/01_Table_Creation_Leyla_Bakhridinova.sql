create table if not exists star.factsupplierpurchases
(
    purchaseid          serial primary key,
    supplierid          int,
    totalpurchaseamount decimal,
    purchasedate        date,
    numberofproducts    int,
    foreign key (supplierid) references star.dimsupplier (supplierid)
);
