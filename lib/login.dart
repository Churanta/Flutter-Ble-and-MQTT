import 'package:flutter/material.dart';
import 'package:heat_pump/MainPage.dart';
import 'package:heat_pump/email.dart';
import 'package:heat_pump/services/auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController countryCode = TextEditingController();

  var email = "";
  var password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/p3.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Wealcome To HeatPump",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Login To your account",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 55, 239, 249),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (await login(email, password, context))
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                    },
                    // onPressed: () async {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const MainPage()),
                    //   );
                    // },
                    child: const Text("Login")),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyEmail()),
                  );
                },
                child: const Text('New User ?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
