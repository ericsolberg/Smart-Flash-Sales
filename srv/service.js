/**
 * Code is auto-generated by Application Logic, DO NOT EDIT.
 * @version(2.0)
 */
const LCAPApplicationService = require('@sap/low-code-event-handler');
const flashsales_ApproveSale = require('./code/flashsales-approveSale');
const flashsales_StartSale = require('./code/flashsales-startSale');
const flashsales_RejectSale = require('./code/flashsales-rejectSale');
const flashsales_EndSale = require('./code/flashsales-endSale');
const flashsales_OnCreate = require('./code/flashsales-onCreate');
const flashsales_AfterCreate = require('./code/flashsales-afterCreate');
const resetdevices_Logic = require('./code/resetdevices-logic');
const eslSimulator = require('./code/eslSimulator');

class flashsalesSrv extends LCAPApplicationService {

    async init() {

        const messaging = await cds.connect.to('messaging')

        this.on('approveSale', 'FlashSales', async (request, next) => {
            return flashsales_ApproveSale(request);
        });

        this.on('startSale', 'FlashSales', async (request, next) => {
            return flashsales_StartSale(request, messaging);
        });

        this.on('rejectSale', 'FlashSales', async (request, next) => {
            return flashsales_RejectSale(request);
        });

        this.on('endSale', 'FlashSales', async (request, next) => {
            return flashsales_EndSale(request, messaging);
        });

        this.on('CREATE', 'FlashSales', async (request, next) => {
            await flashsales_OnCreate(request);
            return next();
        });

        this.after('CREATE', 'FlashSales', async (results, request) => {
            await flashsales_AfterCreate(results, request);
        });

        this.on('ResetDevices', async (request, next) => {
            return resetdevices_Logic(request);
        });

        messaging.on('eslUpdate', async msg => {
            return eslSimulator(msg);
        })

        return super.init();
    }
}


module.exports = {
    flashsalesSrv
};