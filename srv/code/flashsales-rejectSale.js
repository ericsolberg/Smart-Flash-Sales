/**
 * 
 * @On(event = { "rejectSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = async function(request) {
    const { FlashSales } = cds.entities;

    const result = await cds.run(request.query);
    const { ID } = result[0];

    if (!ID) {
        return request.error(400, 'FlashSale ID is required');
    }

    // Update the status_code to "Rejected"
    await cds.run(UPDATE(FlashSales).set({ status_code: 'Rejected' }).where({ ID }));
}