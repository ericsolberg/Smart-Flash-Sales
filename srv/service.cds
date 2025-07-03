using {ProductMasterA2X} from './external/ProductMasterA2X.cds';
using {flashsales} from '../db/schema.cds';

service flashsalesSrv {
    
    entity FlashSales         as projection on flashsales.FlashSales
        actions {
            @Common.SideEffects: {TargetProperties: ['in/status_code']}
            action startSale();

            @Common.SideEffects: {TargetProperties: ['in/status_code']}
            action endSale();

            action approveSale();
            action rejectSale();
        };

    entity Products           as projection on flashsales.Products;
    entity SaleProducts       as projection on flashsales.SaleProducts;

    event eslUpdate {
        productName   : String;
        regularPrice  : Double;
        shelfLocation : String;
        eslDevice     : String;
        title         : String;
        salePrice     : Double;
        isSale        : Boolean;
    }

    entity ESLSim             as projection on flashsales.ESLSim;
    action ResetDevices();
    action revenueVsCostByWeek();
    action unitsSoldByCategory();
    entity A_ProductBasicText as projection on ProductMasterA2X.A_ProductBasicText;
}
