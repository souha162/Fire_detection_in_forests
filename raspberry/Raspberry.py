import time
import serial
import paho.mqtt.client as mqtt
import random
def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    #client.subscribe("$SYS/#")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect("192.168.43.184", 1883, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
#client.publish("mqtt_temperature", '{"sensor":"pp","temp":"20.00"}')

ser = serial.Serial('/dev/ttyACM0',9600)
#dict={"Humidity":"","Temperature":"","Flame":False}

'''
while(1):
    ch=str(ser.readline())
    if 'Humidity' in ch:
        dict["Humidity"]=ch[16:len(ch)-5]
    if 'Temp' in ch:
        dict["Temperature"]=ch[19:len(ch)-5]
        client.publish("mqtt_temperature", '{"sensor":"x","temp":'+ch[19:len(ch)-5]+'}')
    if 'Fla' in ch:
        dict["Flame"]=True
    else:
        dict["Flame"]=False
'''
ser = serial.Serial('/dev/ttyACM0',9600)

print("\nStart")
print("\nSending Data to Server..")
while(1):
    ch=str(ser.readline())
    if 'Humidity' in ch:
        client.publish("mqtt_humidity", '{"location":"tunis","sensor":"HUM01","hum":'+ch[16:len(ch)-5]+'}')
    if 'Temp' in ch:
        client.publish("mqtt_temperature", '{"location":"jerba","sensor":"TEM01","temp":'+ch[19:len(ch)-5]+'}')
    if 'Fla' in ch:
        client.publish("mqtt_flame", '{"location":"nabeul","sensor":"FLA01","fla":true}')
    else:
        client.publish("mqtt_flame", '{"location":"Morneg","sensor":"FLA01","fla":false}')
