/**
 * 
 * @On(event = { "endSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request, messaging) {
    const LOG = cds.log('eslUpdate')
    const { FlashSales, FlashSalesStatusCodeList, SaleProducts, Products } = cds.entities;

    const result = await cds.run(request.query);
    const { ID } = result[0];

    // Ensure the ID is provided
    if (!ID) {
        return request.error(400, 'FlashSales ID is missing');
    }

    // Update the status_code to "Completed"
    await UPDATE(FlashSales).set({ status_code: 'Completed' }).where({ ID });

    const flashSale = await SELECT.one().from(FlashSales).where({ ID })
    const saleProducts = await SELECT.from(SaleProducts).where({ flashSales_ID: ID });
    for (const sp of saleProducts) {
        const product = await SELECT.one().from(Products).columns('productName', 'regularPrice', 'shelfLocation', 'eslDevice').where({ ID: sp.product_ID });
        const msg = JSON.stringify({ ...product, title: "", salePrice: 0.0, isSale: false })
        LOG.info('< Emitting: ', msg);
        await messaging.emit('eslUpdate', msg)
    }

    return request.reply({ message: 'Flash sale completed successfully.' });


}