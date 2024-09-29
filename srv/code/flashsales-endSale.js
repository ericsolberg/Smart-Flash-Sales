/**
 * 
 * @On(event = { "endSale" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request) {
    const { FlashSales } = cds.entities;

    const result = await cds.run(request.query);
    const { ID } = result[0];

    // Ensure the ID is provided
    if (!ID) {
        return request.error(400, 'FlashSales ID is missing');
    }

    // Update the status_code to "Completed"
    await UPDATE(FlashSales).set({ status_code: 'Completed' }).where({ ID });
}