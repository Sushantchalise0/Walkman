const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const BillingAddressSchema = new Schema({


   detail: {
    type: Schema.Types.ObjectId,
    ref: 'details'
   },
   fullName: {
    type: String,
    default: 'Null'
   },
   phoneNumber: {
    type: Number,
    default: 'Null'
   },
    province: {
        type: String,
        default: "Null"
    },
    city: {
        type: String,
        default: "Null"
    },
    address: {
        type: String,
        default: "Null"
    }
});

// CouponSchema.virtual('qrKey').get(function() {
//     return this._id;
// });

module.exports = mongoose.model('BillingAddress', BillingAddressSchema);