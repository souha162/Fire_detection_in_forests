var humidityModel = require('../models/humidity.js')
var flameModel = require('../models/flame.js')
var temperatureModel = require('../models/temperature.js')
const sensorRouter = require('express').Router()


sensorRouter.get('/temperature',(req,res)=>{
    let { startDate, endDate } = req.query;
        if(startDate === '' || endDate === '') {
            return res.status(400).json({
                status:'failure',
                message: 'Please ensure you pick two dates'
                })
                }
    //console.log({ startDate, endDate});
    temperatureModel.find({ 
        
        date: {
              $gte: new Date(new Date(startDate).setHours(00, 00, 00)),
              $lt: new Date(new Date(endDate).setHours(23, 59, 59))
               }
        }).sort({ date: 'asc'}).then(mesure=>{
            res.status(200).json(mesure)
        }).catch(err=>{
            res.status(500).json({error: err.message})
    })
    
})

sensorRouter.get('/humidity',(req,res)=>{
    let { startDate, endDate } = req.query;
    if(startDate === '' || endDate === '') {
        return res.status(400).json({
            status:'failure',
            message: 'Please ensure you pick two dates'
             })
            }
    //console.log({ startDate, endDate});
    humidityModel.find({ 
        
        date: {
              $gte: new Date(new Date(startDate).setHours(00, 00, 00)),
              $lt: new Date(new Date(endDate).setHours(23, 59, 59))
               }
        }).sort({ date: 'asc'}).then(mesure=>{
            res.status(200).json(mesure)
        }).catch(err=>{
            res.status(500).json({error: err.message})
    })
    
})

sensorRouter.get('/flame',(req,res)=>{
    let { startDate, endDate } = req.query;
    if(startDate === '' || endDate === '') {
        return res.status(400).json({
            status:'failure',
            message: 'Please ensure you pick two dates'
             })
            }
    //console.log({ startDate, endDate});
    flameModel.find({ 
        
        date: {
              $gte: new Date(new Date(startDate).setHours(00, 00, 00)),
              $lt: new Date(new Date(endDate).setHours(23, 59, 59))
               }
        }).sort({ date: 'asc'}).then(mesure=>{
            res.status(200).json(mesure)
        }).catch(err=>{
            res.status(500).json({error: err.message})
    })
    
})
module.exports = sensorRouter;
