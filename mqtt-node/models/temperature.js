var mongoose = require('mongoose');

//Define a schema
var Schema = mongoose.Schema;

var temperatureSchema = new Schema({
    location: String,
    sensor: String,
    date: Date,
    temperatureValue : String
});

//Export model
module.exports = mongoose.model('temperatureModel', temperatureSchema );
