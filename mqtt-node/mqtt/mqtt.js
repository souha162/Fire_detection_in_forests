var mqtt = require('mqtt')
var mqtt_host = 'proxy16.rt3.io'
var mqtt_port = '33893'
var mqtt_clientId = `node_server`

var connectUrl = `mqtt://${mqtt_host}:${mqtt_port}`
var client = mqtt.connect(connectUrl, {
    mqtt_clientId,
    clean: true,
    connectTimeout: 4000,
    username: 'emqx',
    password: 'public',
    reconnectPeriod: 1000,
})
////////////////////////////////////
var humidity_topic = 'mqtt_humidity'
var flame_topic = 'mqtt_flame'
var temperature_topic = 'mqtt_temperature'

client.on('connect', () => {
    console.log('Connected')
    /////////////////////////////////////////////////
    // Subscribing to topics
    console.log('Subscribing to humidity_topic')
    client.subscribe([humidity_topic], () => {
        console.log(`Subscribed to topic '${humidity_topic}'`)
    })

    console.log('Subscribing to flame_topic')
    client.subscribe([flame_topic], () => {
        console.log(`Subscribed totopic '${flame_topic}'`)
    })

    console.log('Subscribing to temperature_topic')
    client.subscribe([temperature_topic], () => {
        console.log(`Subscribed totopic '${temperature_topic}'`)
    })
    //////////////////////////////////////////////////
    
    /*client.publish(topic, 'nodejs mqtt test', { qos: 0, retain: false }, (error) => {
        if (error) {
            console.error(error)
        }
    })*/
})


module.exports = client;
