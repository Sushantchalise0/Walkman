const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UnitSchema = new Schema({

    unit:{
        type: String,
        default: 0
    }
});

module.exports = mongoose.model('UnitSchema', UnitSchema);