import 'package:flutter/material.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  String selectedFruit = 'Apple';
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();

  @override
  void dispose() {
    temperatureController.dispose();
    humidityController.dispose();
    super.dispose();
  }

  void submitData() {
    String selectedFruit = this.selectedFruit;
    String desiredTemperature = temperatureController.text;
    String desiredHumidity = humidityController.text;

    // Perform further actions with the submitted data
    // For example, send the data through Bluetooth

    // Print the submitted data for demonstration
    print('Selected Fruit: $selectedFruit');
    print('Desired Temperature: $desiredTemperature');
    print('Desired Humidity: $desiredHumidity');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Page'),
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        padding: EdgeInsets.all(16.0),
        child: Column(
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
                primary: Colors.blue, // Set button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
