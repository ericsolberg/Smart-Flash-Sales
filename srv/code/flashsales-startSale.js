/**
 * 
 * @On(event = { "startSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request) {
    const { FlashSales, FlashSalesStatusCodeList } = cds.entities;

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

    return request.reply({ message: 'Flash sale started successfully.' });
}