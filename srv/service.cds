using {ProductMasterA2X} from './external/ProductMasterA2X.cds';
using {flashsales} from '../db/schema.cds';

service flashsalesSrv {
    @odata.draft.enabled
    entity FlashSales         as projection on flashsales.FlashSales
        actions {
            @(
                //Update the UI after action
                Common.SideEffects     : {TargetProperties: ['in/status_code']},
                Core.OperationAvailable: {$edmJson: {$Eq: [
                    {$Path: 'in/status_code'},
                    'Ready'
                ]}}
            ) action startSale();

            @(
                //Update the UI after action
                Common.SideEffects     : {TargetProperties: ['in/status_code']},
                Core.OperationAvailable: {$edmJson: {$Eq: [
                    {$Path: 'in/status_code'},
                    'Running'
                ]}}
            )
            action   endSale();

            action   approveSale();
            action   rejectSale();
        };

    entity Products           as projection on flashsales.Products;

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

    entity A_ProductBasicText as projection on ProductMasterA2X.A_ProductBasicText;
}
