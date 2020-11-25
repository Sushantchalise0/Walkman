const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ProductSchema = new Schema({
	vendor_id: {
		type: Schema.Types.ObjectId,
		ref: "Vendors"
	},
	name: {
		type: String,
		default: "empty"
	},

	img: {
		type: String,
		default: "empty"
	},
	coins: {
		type: String,
		default: 0
	},
	desc: {
		type: String,
		default: "empty"
	},
	date: {
		type: Date,
		default: Date.now
	},
	act_price: {
		type: String,
		default: 0
	},
	disc_price: {
		type: String,
		default: 0
	},
	walkman_price: {
		type: String,
		default: 0
	},
	status: {
		type: Boolean,
		default: 0
	}, 
	ratings:{
        type: String,
        default: 0
    }
});

module.exports = mongoose.model("Products", ProductSchema);
