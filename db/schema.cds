namespace flashsales;

using { sap.common.CodeList } from '@sap/cds/common';

entity FlashSalesStatusCodeList : CodeList
{
    key code : String(20) default 'New'
        @Common.Text : name
        @Common.Text.@UI.TextArrangement : #TextOnly;
    criticality : Integer;
}

entity FlashSales
{
    key ID : UUID;
    startDate : Date;
    title : String(50);
    description : String;
    status : Association to one FlashSalesStatusCodeList;
    saleProducts : Composition of many SaleProducts on saleProducts.flashSales = $self;
}

entity SaleProducts
{
    key ID : UUID;
    salePrice : Decimal
        @mandatory;
    product : Association to one Products;
    flashSales : Association to one FlashSales;
}

entity Products
{
    key ID : UUID;
    productID : String(50);
    productName : String(50);
    regularPrice : Decimal;
    shelfLocation : String;
    eslDevice : String;
}
