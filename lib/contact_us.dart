// this page is for contact detais for the customer care
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(height: 30),

          const Text(
            'Find the Service Center near by',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
          ),
          const SizedBox(height: 30),
          //card
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Mobile Number'),
                  subtitle: Text('8904229596'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Area'),
                  subtitle: Text('Yelhanka, Bengaluru'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(22)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Mobile Number'),
                  subtitle: Text('6291731887'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Area'),
                  subtitle: Text('Peenya, Bengaluru'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
