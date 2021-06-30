const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const WeeklyDataSchema = new Schema({


   detail: {
    type: Schema.Types.ObjectId,
    ref: 'details'
   },

   distance: {
        type: Number,
        default: 0    },

    start_time: {
        type: Date
    },

    end_time: {
        type: Date
        
    }
});

module.exports = mongoose.model('WeeklyData', WeeklyDataSchema);