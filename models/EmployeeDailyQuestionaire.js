const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const EQuestionSchema = new Schema({


   question: {
    type: String,
    default: 'empty'
   },
   ansOne: {
    type: String,
    default: 'empty'
   },
   ansTwo: {
    type: String,
    default: 'empty'
   },
   ansThree: {
    type: String,
    default: 'empty'
   },
   ansFour: {
    type: String,
    default: 'empty'
   },
   ansOneCoins: {
    type: Number,
    default: 0
   },
   ansTwoCoins: {
    type: Number,
    default: 0
   },
   ansThreeCoins: {
    type: Number,
    default: 0
   },
   ansFourCoins: {
    type: Number,
    default: 0
   }
});

module.exports = mongoose.model('EQuestions', EQuestionSchema);