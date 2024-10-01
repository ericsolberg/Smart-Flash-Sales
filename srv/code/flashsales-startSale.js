/**
 * 
 * @On(event = { "startSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function (request, messaging) {

    const LOG = cds.log('eslUpdate')

    const { FlashSales, FlashSalesStatusCodeList, SaleProducts, Products } = cds.entities;

    const result = await cds.run(request.query);
    const { ID } = result[0];

    // Check if the ID is defined
    if (!ID) {
        return request.error(400, 'FlashSales ID is missing.');
    }

    // Retrieve the "Running" status code from FlashSalesStatusCodeList
    const runningStatus = await SELECT.one.from(FlashSalesStatusCodeList).where({ code: 'Running' });

    // Check if the "Running" status code exists
    if (!runningStatus) {
        return request.error(404, 'Status code "Running" not found.');
    }

    // Update the status of the FlashSales entity to "Running"
    await cds.run(UPDATE(FlashSales).set({ status_code: runningStatus.code }).where({ ID }));

    const flashSale = await SELECT.one().from(FlashSales).where({ ID })
    const saleProducts = await SELECT.from(SaleProducts).where({ flashSales_ID: ID });
    for (const sp of saleProducts) {
        const product = await SELECT.one().from(Products).columns('productName', 'regularPrice', 'shelfLocation', 'eslDevice').where({ ID: sp.product_ID });
        const eslData = { ...product, title: flashSale.title, salePrice: sp.salePrice, isSale: true };
        const msg = JSON.stringify(eslData);
        LOG.info('< Emitting: ', msg);
        await messaging.emit('eslUpdate', msg)
    }

    return request.reply({ message: 'Flash sale started successfully.' });
}