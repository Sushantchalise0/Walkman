const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const CartSchema = new Schema({

    _id : { type : String, required : true },
    
   detail: {
    type: Schema.Types.ObjectId,
    ref: 'details'
   },
   productID: [{
    type: Schema.Types.ObjectId,
    ref: 'Products'
   }],
    // comments: [{
    //     type: Schema.Types.ObjectId,
    //     ref: 'comments'
    // }] 
   isProductDeliverd: {
    type: Boolean,
    default: 0
   },
    dateOfOrdered: {
        type: Date,
        default: Date.now
    },
    dateOfDelivery: {
        type: Date,
        default: "soon"
    },
    created_date: {
        type: Date,
        default: Date.now
    }
});

// CouponSchema.virtual('qrKey').get(function() {
//     return this._id;
// });

module.exports = mongoose.model('Cart', CartSchema);