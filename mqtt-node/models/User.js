const mongoose = require("mongoose")


const UserSchema = new mongoose.Schema({
    email:{
        type : String,
        required : [true,'please enter an email addresse']
    },
    userName:{
        type: String,
        required : [true,'please enter a first name']
    },
    
    password:{
        type : String,
        required : [true,'please enter a password']
    },
    service : {
        type : String,
        required : [true,'please enter a service']
    },
    phoneNumber:{
        type : String,
        required : [true,'please enter a bio']
    },
    picUrl : {
        type: String,
        required : [true, 'please enter picURL']
    }

})


module.exports = mongoose.model('User', UserSchema)