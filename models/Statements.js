const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const StatementSchema = new Schema({
	vendor_id: {
		type: Schema.Types.ObjectId,
		ref: "Vendors"
	},
	product_id: {
		type: Schema.Types.ObjectId,
		ref: "Products"
	},
	redeemedDate: {
		type: Date,
		default: Date.now
	},
	redeemedTime: {
		type: Date,
		default: Date.now
	},
	due: {
		type: String,
		default: 0
	}
});

module.exports = mongoose.model("Statements", StatementSchema);
