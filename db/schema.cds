namespace flashsales;

using { ProductMasterA2X } from '../srv/external/ProductMasterA2X.cds';

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

entity ESLSim
{
    key ID : UUID;
    productName : String(50);
    regularPrice : Double;
    shelfLocation : String(100);
    eslDevice : String(100);
    title : String(50);
    salePrice : Double;
    isSale : Boolean;
}
