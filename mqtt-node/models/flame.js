var mongoose = require('mongoose');

//Define a schema
var Schema = mongoose.Schema;

var flameSchema = new Schema({
    location: String,
    sensor: String,
    date: Date,
    flameValue : Boolean
});

//Export model
module.exports = mongoose.model('flameModel', flameSchema );
