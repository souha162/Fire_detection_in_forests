# **Introduction**
--
Fire detection in forests is a mobile application dedicated to fire fighters. The application displays temperature and humidity values between two different dates as well as the presence of fire or not. These values will be measured by sensors.
# **Architecture**
![Alt text](/C:/Users/nemri souha/Documents/GitHub/Detection-of-fires-in-forests/Capture.PNG)
# **Technology Choice** 
-   Frontend Part : Flutter 
- Backend Part : MongoDB Atlas - Mosquitto MQTT broker
- Middleware Part : NodeJS
- IOT Part: Raspberry Pi and Temperature and Humidity sensors


# **Middleware**
In the Azure virtual machine we have the mqtt broker mosquitto and the node js server.

To make sure that our MQTT Broker is running, all you have to do is verify with this command:  
```python
sudo systemctl status moquitto
```
# **Certification**

We were able to activate HTTPS by using Certbot from Let's Encrypt and then we were able to check the domain and make sure that our site is secure from different connections 
We were able to deploy our NodeJS middleware on an Azure virtual machine using a Linux OS (ubuntu 20.04) and accessible via the URL projetcot.me.
This server is secured by a Wildard SSL certificate associated with an rsa 4096 key, issued by Let's Encrypt.


```python
./certbot-auto certonly --manual -d *.$projetcot.me -d $projetcot.me --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --register-unsafely-without-email --rsa-key-size 4096
```
# **Results**
