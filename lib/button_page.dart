import 'package:flutter/material.dart';
import 'package:heat_pump/BluetoothPage.dart';
import 'package:heat_pump/MQTTPage.dart';

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // First button
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[900],
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: Size(double.infinity, 80.0), // Increased height
                ),
                child: GestureDetector(
                  onTap: () {
                    // Your onPressed function logic here
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BluetoothPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.teal],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26.0, vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.bluetooth,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Bluetooth',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 26.0),
            // Second button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[900],
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                minimumSize: Size(double.infinity, 80.0), // Increased height
              ),
              child: GestureDetector(
                onTap: () {
                  // Your onPressed function logic here
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MQTTPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26.0, vertical: 16.0), // Increased height
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.wifi,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'MQTT',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
