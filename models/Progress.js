const { date } = require('faker');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const ProgressSchema = new Schema({


   detail: {
    type: Schema.Types.ObjectId,
    ref: 'details'
   },

   distance: {
        type: Number,
        default: 0    },

    calorie: {
        type: Number,
        default: 0
    },

    carbon_red: {
        type: Number,
        default: 0
    },

    coins: {
        type: Number,
        default: 0
    },

    last_updated: {
        type: String,
        default: Date.now
    },

    time: [{
        start_time: Number,
        end_time: Number,
        count: Number
    }]
});

module.exports = mongoose.model('Progress', ProgressSchema);