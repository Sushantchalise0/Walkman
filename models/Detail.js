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

   fb_id: {
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
    email:{
        type: String,
        default: 0
    }

});

module.exports = mongoose.model('details', DetailSchema);
