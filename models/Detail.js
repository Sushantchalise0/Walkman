const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const DetailSchema = new Schema({

    user_name: {
        type: String,
        required: true
    },

   user_img: {
    type: String,
    default: 'empty'
   },

   email_id: {
       type: String,
       default: '0'
   },
   gender: {
       type: String,
       default: 'none'
   },
   companyCode:{
    type: String,
    default: 0
    },
    phone_number:{
        type: String,
        default: 0
    },
    dob: {
        type: String,
        default: '1990-10-12'
    }

});

module.exports = mongoose.model('details', DetailSchema);
