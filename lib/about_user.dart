import 'package:flutter/material.dart';
import 'package:heat_pump/Password.dart';
import 'package:heat_pump/providers/authProvider.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class AboutUser extends StatelessWidget {
  const AboutUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0), // Added top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://iso.500px.com/wp-content/uploads/2016/03/stock-photo-142984111-1500x1000.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.watch<UserProvider>().user.uname ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Email: ${context.watch<UserProvider>().user.uemail ?? ''}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  context.read<UserProvider>().deleteUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyLogin()),
                  );
                },
                icon: const Icon(Icons.logout),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildUserDetailItem(
                    icon: Icons.phone,
                    title: 'Mobile Number',
                    subtitle: context.watch<UserProvider>().user.uphone ?? '',
                  ),
                  const SizedBox(height: 10),
                  _buildUserDetailItem(
                    icon: Icons.location_on,
                    title: 'Area',
                    subtitle: context.watch<UserProvider>().user.city ?? '',
                  ),
                  const SizedBox(height: 10),
                  _buildUserDetailItem(
                    icon: Icons.devices,
                    title: 'Number of Devices',
                    subtitle:
                        context.watch<UserProvider>().user.totaldev.toString(),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPassword()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: _buildUserDetailItem(
                  icon: Icons.lock,
                  title: 'Update Password',
                  subtitle: '',
                  showChevron: true,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetailItem(
      {required IconData icon,
      required String title,
      required String subtitle,
      bool showChevron = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 248, 209, 255),
            ),
            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (showChevron) Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }
}
