import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController phoneEC = TextEditingController();
  final TextEditingController passEC = TextEditingController();
  final TextEditingController pass2EC = TextEditingController();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Registration")),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                height: 300,
                color: Colors.blue,
                child: Image.asset('assets/images/registration.jpg',
                    fit: BoxFit.cover)),
            Card(
              elevation: 8,
              child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(children: [
                    const Text("Registration Form"),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: nameEC,
                                validator: (val) =>
                                    val!.isEmpty || (val.length < 5)
                                        ? "Name Must Be Longer Than 5"
                                        : null,
                                decoration: const InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(),
                                    icon: Icon(Icons.person),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ))),
                            TextFormField(
                                controller: phoneEC,
                                validator: (val) =>
                                    val!.isEmpty || (val.length < 10)
                                        ? "Name Must Be Longer or Equal than 10"
                                        : null,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    labelText: 'Phone',
                                    labelStyle: TextStyle(),
                                    icon: Icon(Icons.phone),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ))),
                            TextFormField(
                                controller: emailEC,
                                validator: (val) => val!.isEmpty ||
                                        !val.contains("@") ||
                                        (!val.contains("."))
                                    ? "Please enter a valid email"
                                    : null,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    labelStyle: TextStyle(),
                                    icon: Icon(Icons.email),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ))),
                            TextFormField(
                                controller: passEC,
                                validator: (val) =>
                                    val!.isEmpty || (val.length < 5)
                                        ? "Password Must Be Longer Than 5"
                                        : null,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(),
                                    icon: Icon(Icons.lock),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ))),
                            TextFormField(
                                controller: pass2EC,
                                validator: (val) =>
                                    val!.isEmpty || (val.length < 5)
                                        ? "Password Must Be Longer Than 5"
                                        : null,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Re-enter Password',
                                    labelStyle: TextStyle(),
                                    icon: Icon(Icons.lock),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ))),
                            const SizedBox(height: 16),
                            Row(children: [
                              Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  }),
                              GestureDetector(
                                onTap: null,
                                child: const Text('Agree with terms',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: onRegisterDialog,
                                    child: const Text("Register")),
                              ),
                            ]),
                          ],
                        ))
                  ])),
            )
          ],
        )));
  }

  void onRegisterDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your Input")));
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please agree with terms and conditions")));
      return;
    }

    String pass1 = passEC.text;
    String pass2 = pass2EC.text;
    if (pass1 != pass2) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please check your password")));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register New Account",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void registerUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
              title: Text("Please Wait"), content: Text("Registration..."));
        });
    String name = nameEC.text;
    String email = emailEC.text;
    String phone = phoneEC.text;
    String password = passEC.text;

    http.post(
        Uri.parse("http://10.144.178.53/barterit/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        }).then((response) {
      //print(response.body);

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successful")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
        Navigator.pop(context);
      }
    });
  }
}
