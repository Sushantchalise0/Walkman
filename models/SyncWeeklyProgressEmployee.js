const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const SyncWeeklyProgressSchema = new Schema({

   question_id: {
    type: Schema.Types.ObjectId,
    ref: 'EWeeklyQuestion'
    },
   coins: {
    type: Number,
    default: 0
   },
   status: {
    type: Number,
    default: 0
   },
   weekNo: {
    type: Number,
    default: 0
   },
   detail: {
    type: Schema.Types.ObjectId,
    ref: 'details'
    }
});

module.exports = mongoose.model('SyncWeeklyProgress', SyncWeeklyProgressSchema);