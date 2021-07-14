const { date } = require('faker');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const ReviewSchema = new Schema({


   detail: {
    type: Schema.Types.ObjectId,
    ref: 'details'
   },

   body: {
        type: String,
        default: "Null"    },

    productID: {
        type: Schema.Types.ObjectId,
        ref: 'products'
    },

    rating: {
        type: Number,
        default: 0
    },

    Date: {
        type: String,
        default: Date.now
    }
    // ,

    // time: [{
    //     start_time: Number,
    //     end_time: Number,
    //     count: Number
    // }]
});

module.exports = mongoose.model('Reviews', ReviewSchema);