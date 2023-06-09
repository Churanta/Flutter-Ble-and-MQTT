import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class MQTTPage extends StatefulWidget {
  @override
  _MQTTPageState createState() => _MQTTPageState();
}

class _MQTTPageState extends State<MQTTPage> {
  final TextEditingController _messageController = TextEditingController();
  mqtt.MqttClient? client;

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
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _messageController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Message',
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
            ElevatedButton(
              onPressed: () {
                String message = _messageController.text;
                _publishMessage('topic', message);
              },
              child: Text('Publish'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
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
