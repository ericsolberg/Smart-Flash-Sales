using {flashsales} from '../db/schema.cds';

service flashsalesSrv {
    @odata.draft.enabled
    entity FlashSales as projection on flashsales.FlashSales
        actions {
            @(
                //Update the UI after action
                Common.SideEffects     : {TargetProperties: ['in/status_code']},
                Core.OperationAvailable: {$edmJson: {$Eq: [
                    {$Path: 'in/status_code'},
                    'Ready'
                ]}}
            )
            action startSale();
            @(
                //Update the UI after action
                Common.SideEffects     : {TargetProperties: ['in/status_code']},
                Core.OperationAvailable: {$edmJson: {$Eq: [
                    {$Path: 'in/status_code'},
                    'Running'
                ]}}
            )
            action endSale();
            action approveSale();
            action rejectSale();
        }

    entity Products   as projection on flashsales.Products;
}
