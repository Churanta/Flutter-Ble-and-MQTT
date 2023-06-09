// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:heat_pump/MainPage.dart';
import 'package:heat_pump/models/deviceModel.dart';
import 'package:heat_pump/providers/authProvider.dart';
import 'package:heat_pump/services/sendDevTemp.dart';
import 'package:heat_pump/services/updateDevice.dart';
import 'package:heat_pump/wifi_page.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';

const String mqttBroker = "hmqtt.thinkfinitylabs.com";
const int mqttPort = 1883;
const String mqttUsername = "hdevices";
const String mqttPassword = "Test@123";
// const String mqttTopic = "testtopic/";

class Remote extends StatefulWidget {
  final int index;
  DeviceModel currDev;

  Remote(this.index, this.currDev, {super.key});

  @override
  State<Remote> createState() => _RemoteState();
}

class _RemoteState extends State<Remote> {
  final TextEditingController _textController = TextEditingController();
  final client = MqttServerClient(mqttBroker, '');
  bool _isConnected = false;
  double dtemp = 5;
  double temp = 50;
  bool dstate = false;

  @override
  void initState() {
    super.initState();
    dstate = int.parse(widget.currDev.dstate ?? "0") == 1;
    _connectToMqttBroker();
  }

  void _connectToMqttBroker() async {
    client.port = mqttPort;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .authenticateAs(mqttUsername, mqttPassword)
        .startClean();
    client.connectionMessage = connMessage;
    try {
      await client.connect();
      setState(() {
        _isConnected = true;
      });
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  void _onDisconnected() {
    setState(() {
      _isConnected = false;
    });
    print('Disconnected from MQTT broker');
  }

  void _sendMessage() {
    if (_isConnected) {
      final message =
          '{"dtemp":"$dtemp","temp":"$temp","device id": "${widget.currDev.deviceid}","user Id":"${context.read<UserProvider>().user.uid}","Device State":"${widget.currDev.dstate}"}';
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      print("///////////////////////////////////////");
      print(dstate);
      print("///////////////////////////////////////");
      client.publishMessage("testtopic/${widget.currDev.deviceid}",
          MqttQos.atLeastOnce, builder.payload!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Device Name : ${widget.currDev.dname}')),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Current Temperature :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              '${widget.currDev.temp} \u00B0C',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 35.0),
            const Text(
              'Set Differentiate Temperature:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: SpinBox(
                min: 5,
                max: 10,
                value: dtemp,
                keyboardType: TextInputType.none,
                readOnly: true,
                onChanged: (value) => dtemp = value,
              ),
            ),
            const SizedBox(height: 25.0),
            const Text(
              'Set Temperature:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: SpinBox(
                min: 35,
                max: 80,
                value: temp,
                keyboardType: TextInputType.none,
                readOnly: true,
                onChanged: (value) => temp = value,
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                fixedSize: const Size(180, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 26.0,
              ),
              label: Text(dstate == false ? "ON" : "OFF"),
              onPressed: () async {
                if (await updateDevice(context, dtemp, temp,
                    widget.currDev.deviceid ?? "", !dstate)) {
                  _sendMessage(); // Add this line to send message
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Success',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      content: const Icon(
                        Icons.check,
                        size: 50,
                        color: Colors.green,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage())),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        )));
  }
}
