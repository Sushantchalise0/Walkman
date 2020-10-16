const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const AddcoinSchema = new Schema({

    
    detail: {
        type: Schema.Types.ObjectId,
        ref: 'details',
        required:false
       },
       mailid:{
        type: String,
        default: 0
    },
    unit:{
        type: String,
        default: 0
    },
    metric:{
        type: String,
        default: 0
    },
    coins:{
        type: String,
        default: 0
    } ,
    addedDate:{
        type: Date,
        default: Date.now()
    }
});

module.exports = mongoose.model('Addcoin', AddcoinSchema, 'addcoin');