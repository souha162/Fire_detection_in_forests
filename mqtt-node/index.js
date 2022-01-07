//Oussama Lariani
//mongodb+srv://oussamalariani25800:1798hardersupAAA@cluster0.wnyke.mongodb.net/myFirstDatabase?retryWrites=true&w=majority


client = require('./mqtt/mqtt.js')
sensorsRouter = require('./api/sensorsRoutes.js')
usersRouter = require('./api/userRoutes.js')
const mongoose = require('mongoose');
const express = require('express')
const cors=require("cors");

const humidity_topic = 'mqtt_humidity'
const flame_topic = 'mqtt_flame'
const temperature_topic = 'mqtt_temperature'

const port= 3000
//const userRoutes = require('./api/UserRoutes')
const app =express()

const corsOptions ={
    origin:'*', 
    credentials:false,            //access-control-allow-credentials:true
    optionSuccessStatus:200,
}
 
app.use(cors(corsOptions)) 

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");    
    next();
});

app.use(express.json())

app.use('/api/sensors/',sensorsRouter)   
app.use('/api/users/',usersRouter)   
app.use(cors())

app.get('/',(req,res)=>{
    res.send('hello world')
})

///////////////////////

var humidityModel = require('./models/humidity.js')
var flameModel = require('./models/flame.js')
var temperatureModel = require('./models/temperature.js')


/////////////////////////////////////////
const mongodb_address = 'mongodb+srv://oussamalariani25800:1798hardersupAAA@cluster0.wnyke.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'


///////////////////////////////////////
mongoose.connect(mongodb_address).then(
    ()=>{
        app.listen(port,()=>{
            console.log('app running ....')
        })
    }
).catch(err=>console.log(err))

//Get the default connection
var db = mongoose.connection;

//Bind connection to error event (to get notification of connection errors)
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
////////////////////////////////////////
var temperatures = []
var humidities = []
var flames = []
function addTemperatureMesure(sensorName, date, temp) {
    tempdetail = {sensor: sensorName,date: date,temperatureValue : temp}
    var temperatureMesure = new temperatureModel(tempdetail);
         
    temperatureMesure.save(function (err) {
      if (err) {
        console.log(err);
        return
      }
      console.log('New temp mesure: ' + temperatureMesure);
      temperatures.push(temperatureMesure)
    }  );
  }

function addHumidityMesure(sensorName, date, hum) {
    humdetail = {sensor: sensorName,date: date,humidityValue : hum}
    var humidityMesure = new humidityModel(humdetail);
         
    humidityMesure.save(function (err) {
      if (err) {
        console.log(err);
        return
      }
      console.log('New hum mesure: ' + humidityMesure);
      humidities.push(humidityMesure)
    }  );
  }

function addFlameMesure(sensorName, date, flame) {
    flamedetail = {sensor: sensorName,date: date,flameValue : flame}
    var FlameMesure = new flameModel(flamedetail);
         
    FlameMesure.save(function (err) {
      if (err) {
        console.log(err);
        return
      }
      console.log('New flame mesure: ' + FlameMesure);
      flames.push(FlameMesure)
    }  );
  }



client.on('message', (topic, payload) => {
    let ts = Date.now();
    let date_ob = new Date(ts);
    switch (topic) {
        case temperature_topic:
            addTemperatureMesure(
                JSON.parse(payload.toString())['sensor'], 
                date_ob, 
                JSON.parse(payload.toString())['temp'])
        break;
        case humidity_topic:
            addHumidityMesure(
                JSON.parse(payload.toString())['sensor'], 
                date_ob, 
                JSON.parse(payload.toString())['hum'])
        break;
        case flame_topic:
            addFlameMesure(
                JSON.parse(payload.toString())['sensor'], 
                date_ob, 
                JSON.parse(payload.toString())['fla'])
        break;

        default:
          console.log(`Sorry, topic not recognized.`);
      }
    //console.log('Received Message:', topic, payload.toString())
})




