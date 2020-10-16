const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const EWeeklyQuestionSchema = new Schema({
   question: {
    type: String,
    default: 'empty'
   },
   coins: {
    type: Number,
    default: 0
   }
});

module.exports = mongoose.model('EWeeklyQuestion', EWeeklyQuestionSchema);