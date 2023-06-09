import 'package:flutter/material.dart';
import 'package:heat_pump/Chat_Page.dart';
import 'package:heat_pump/models/deviceModel.dart';
import 'package:heat_pump/services/getDevices.dart';
import 'package:heat_pump/services/updateDevice.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<DeviceModel> allDevices = [];

  TextEditingController changeDevName = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      allDevices = await getDevices(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: allDevices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 8, // horizontal spacing
                mainAxisSpacing: 8, // vertical spacing
                childAspectRatio: 3 / 2, // 3:2 aspect ratio
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FutureBuilder(
                          future: Future.delayed(const Duration(seconds: 3)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Remote(index, allDevices[index]);
                            } else {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: Center(
                                  child: SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10),
                                        Text("Connecting to the device...."),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 7.0),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.more_vert_rounded),
                                tooltip: 'Edit Device Name',
                                color: Colors.white,
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Enter New Device Name',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      content: TextField(
                                        controller: changeDevName,
                                        decoration: InputDecoration(
                                            labelText: 'Edit device name',
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        onChanged: (value) {
                                          // do something
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        ),
                                        TextButton(
                                          onPressed: () async => {
                                            if (await updateName(
                                                context,
                                                allDevices[index].deviceid ??
                                                    "",
                                                changeDevName.text))
                                              Navigator.pop(context, 'Cancel')
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Text(
                              'Device Name: ${allDevices[index].dname} \n Temp: ${allDevices[index].temp} \n Device Status: ${allDevices[index].dstate == "1" ? "ON" : "OFF"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )));
  }
}
