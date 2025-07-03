import redir from './flashsales-onCreate.js';

/**
 * 
 * @On(event = { "CREATE" }, entity = "flashsalesSrv.FlashSales")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = redir;