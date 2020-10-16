const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const TreasureHuntSchema = new Schema({


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
   correctAnswer: {
    type: String,
    default: 'empty'
   },
   coins: {
    type: Number,
    default: 0
   }
  
});

module.exports = mongoose.model('TreasureHunt', TreasureHuntSchema);