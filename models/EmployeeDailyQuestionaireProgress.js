const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const EQuestionProgressSchema = new Schema({


    detail: {
        type: Schema.Types.ObjectId,
        ref: 'details'
    },
    question_id: {
        type: Schema.Types.ObjectId,
        ref: 'EQuestions'
    },
   answer: {
    type: Number,
    default: 0
   },
   coins: {
    type: Number,
    default: 0
   },
   date: {
    type: Date,
    default: Date.now
    }
});

module.exports = mongoose.model('EQuestionProgress', EQuestionProgressSchema);