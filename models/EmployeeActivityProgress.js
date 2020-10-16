const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const EActivityProgressSchema = new Schema({


    detail: {
        type: Schema.Types.ObjectId,
        ref: 'details'
    },
   walkCoins: {
    type: Number,
    default: 0
   },
   treasureHuntCoins: {
    type: Number,
    default: 0
   },
   weeklyActivityCoins: {
    type: Number,
    default: 0
   },
   WTWACoins: {
    type: Number,
    default: 0
   }
});

module.exports = mongoose.model('EActivityProgress', EActivityProgressSchema);