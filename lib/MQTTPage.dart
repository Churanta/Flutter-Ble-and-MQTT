import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class MQTTPage extends StatefulWidget {
  @override
  _MQTTPageState createState() => _MQTTPageState();
}

class _MQTTPageState extends State<MQTTPage> {
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  mqtt.MqttClient? client;
  String selectedFruit = 'Apple';

  @override
  void initState() {
    super.initState();
    // Initialize the MQTT client
    client = mqtt.MqttClient('mqtt_server', 'client_id');
    client?.port = 1883;
    client?.keepAlivePeriod = 30;
    client?.onDisconnected = _onDisconnected;
    client?.logging(on: true);

    // Connect to the MQTT server
    _connect();
  }

  void _connect() async {
    try {
      await client?.connect();
      print('Connected to MQTT server');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }

  void _disconnect() {
    client?.disconnect();
    print('Disconnected from MQTT server');
  }

  void _onDisconnected() {
    print('Disconnected');
    // Perform any reconnection logic here
  }

  void _publishMessage(String topic, String message) {
    final mqtt.MqttClientPayloadBuilder builder =
        mqtt.MqttClientPayloadBuilder();
    builder.addString(message);
    client?.publishMessage(topic, mqtt.MqttQos.exactlyOnce, builder.payload!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MQTT Demo'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Choose Fruit:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: selectedFruit,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFruit = newValue!;
                      });
                    },
                    items: <String>[
                      'Apple',
                      'Guava',
                      'Chilli',
                      'Grapes',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _temperatureController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Desired Temperature:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _humidityController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Desired Humidity:',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  String temperature = _temperatureController.text;
                  String humidity = _humidityController.text;
                  String message =
                      'Fruit: $selectedFruit, Temperature: $temperature, Humidity: $humidity';
                  _publishMessage('topic', message);
                },
                child: Container(
                  height: 48.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    client?.disconnect();
    super.dispose();
  }
}
