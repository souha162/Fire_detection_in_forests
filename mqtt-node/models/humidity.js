var mongoose = require('mongoose');

//Define a schema
var Schema = mongoose.Schema;

var humiditySchema = new Schema({
    sensor: String,
    date: Date,
    humidityValue : String
});

//Export model
module.exports = mongoose.model('humidityModel', humiditySchema );
