import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothDevice? device;
  BluetoothCharacteristic? characteristic;
  StreamSubscription? subscription;

  String selectedFruit = 'Apple';
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectToDevice();
  }

  @override
  void dispose() {
    subscription?.cancel();
    device?.disconnect();
    temperatureController.dispose();
    humidityController.dispose();
    super.dispose();
  }

  void connectToDevice() async {
    device = // Retrieve the Bluetooth device you want to connect to
        // Use FlutterBlue instance to scan and discover devices
        // or retrieve a known device using its identifier
        // For example:
        await FlutterBlue.instance
            .scan(timeout: Duration(seconds: 4))
            .firstWhere(
                (scanResult) => scanResult.device.name == 'Your Device Name')
            .then((scanResult) => scanResult.device);

    if (device != null) {
      await device!.connect();

      List<BluetoothService> services = await device!.discoverServices();
      services.forEach((service) {
        // Find the desired service
        if (service.uuid.toString() == 'your_service_uuid') {
          service.characteristics.forEach((characteristic) {
            // Find the desired characteristic
            if (characteristic.uuid.toString() == 'your_characteristic_uuid') {
              this.characteristic = characteristic;
              setState(() {});
            }
          });
        }
      });
    }

    if (characteristic != null) {
      subscription = characteristic!.value.listen((value) {
        // Handle incoming data
        String receivedData = String.fromCharCodes(value);
        print('Received data: $receivedData');
      });
    }
  }

  void sendData(String data) {
    if (characteristic != null) {
      List<int> bytes = data.codeUnits;
      characteristic!.write(bytes);
    }
  }

  void submitData() {
    String selectedFruit = this.selectedFruit;
    String desiredTemperature = temperatureController.text;
    String desiredHumidity = humidityController.text;

    // Perform further actions with the submitted data
    // For example, send the data through Bluetooth
    String data = '$selectedFruit,$desiredTemperature,$desiredHumidity';
    sendData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true, // Center the app bar title
        title: Text('Bluetooth Page'),
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  value: selectedFruit,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFruit = newValue!;
                    });
                  },
                  items: <String>['Apple', 'Guava', 'Chilli', 'Grapes']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: temperatureController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter Desired Temperature',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: humidityController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter Desired Humidity',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: submitData,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 5.0,
                    // Apply gradient background color
                    // Replace the colors with your desired gradient colors
                    // You can use any color combination you like
                    // For example, you can use LinearGradient or RadialGradient
                    // LinearGradient(
                    //   colors: [Colors.blue, Colors.green],
                    // )
                    // RadialGradient(
                    //   colors: [Colors.red, Colors.yellow],
                    // )
                    // You can also specify the gradient stops and begin/end points
                    // See the Flutter documentation for more details on gradients
                    // You may need to import 'package:flutter/painting.dart' to use LinearGradient or RadialGradient
                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [Colors.blue, Colors.green],
                    // ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
