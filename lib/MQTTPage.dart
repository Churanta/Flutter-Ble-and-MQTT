import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:lottie/lottie.dart';

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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/tick.json',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Demo'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                  const Text(
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
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  String temperature = _temperatureController.text;
                  String humidity = _humidityController.text;
                  String message =
                      'Fruit: $selectedFruit, Temperature: $temperature, Humidity: $humidity';
                  _publishMessage('topic', message);
                  _showPopup(context);
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
