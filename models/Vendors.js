const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const VendorSchema = new Schema({
    cat_id: {
        type: Schema.Types.ObjectId,
        ref: 'Category'
    },
    vendor_ic: {
        type: String,
        default: 'empty'
    },

    vendor_name:{
        type: String,
        default: 'empty'
    },
    vendor_address:{
        type: String,
        default: 'empty'
    },
    vendor_fb:{
        type: String,
        default: 'empty'
    },
    vendor_insta:{
        type: String,
        default: 'empty'
    },
    vendor_web:{
        type: String,
        default: 'empty'
    },
    vendor_disc:{
        type: String,
        default: 'empty'
    },
    vendor_phone:{
        type: String,
        default: 'empty'
    },
    longitude:{
        type: String,
        default: 'empty'
    },
    lattitude:{
        type: String,
        default: 'empty'
    },
    status:{
        type: Boolean,
        default: 0
    }
    // ,
    // greenPartner:{
    //     type: String,
    //     default: 0
    // },
    // total_coins:{
    //     type: String,
    //     default: 0
    // },
    // total_due:{
    //     type: String,
    //     default: 0
    // },
    // total_sales:{
    //     type: String,
    //     default: 0
    // }
});

module.exports = mongoose.model('Vendors', VendorSchema);