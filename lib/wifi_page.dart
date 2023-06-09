import 'package:flutter/material.dart';
import 'package:heat_pump/MainPage.dart';

class UpdateWiFi extends StatefulWidget {
  const UpdateWiFi({super.key});

  @override
  State<UpdateWiFi> createState() => _UpdateWiFiState();
}

class _UpdateWiFiState extends State<UpdateWiFi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Update Wifi Crediantial')),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Enter Wifi Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 30.0),
            const Text('Enter SSID'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'SSID:',
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text('Enter Password'),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password:',
                ),
              ),
            ),

            const SizedBox(height: 50.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  fixedSize: const Size(180, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              icon: const Icon(
                Icons.key,
                color: Colors.white,
                size: 26.0,
              ),
              label: const Text('Update'),
              onPressed: () {
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
                      // TextButton(
                      //   onPressed: () => Navigator.pop(context, 'Cancel'),
                      //   child: const Text('Cancel'),
                      // ),
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
              },
            ),
            // ElevatedButton(
          ],
        )));
  }
}
