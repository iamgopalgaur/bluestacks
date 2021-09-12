import 'package:bluestacks/utilities/animation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String validateText(String value) {
    if (value.length < 4)
      return 'Please enter min. 3 characters';
    else if (value.length > 11) return 'Characters can\'t be more than 11';
    return '';
  }

  String? phone, password;
  final _formkey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool btnEnabled = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Color(0xff003049)
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.black,
              Colors.black87,
              // Colors.black
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Container(
                      // decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(25)),
                      height: 150,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    // colors: [Colors.blue.shade800, Colors.blue.shade400]),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                            1,
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.toString().length < 3)
                                            return 'Please enter min. 3 characters';
                                          else if (value.toString().length > 11)
                                            return 'Characters can\'t be more than 11';
                                        },
                                        onSaved: (value) {
                                          phone = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Phone number",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: passwordController,
                                        validator: (value) {
                                          if (value.toString().length < 3)
                                            return 'Please enter min. 3 characters';
                                          if (value.toString().length > 11)
                                            return 'Characters can\'t be more than 11';
                                          // else
                                          //   setState(() {
                                          //     btnEnabled = true;
                                          //   });
                                        },
                                        onSaved: (value) => password = value,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          FadeAnimation(
                            1.6,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 170,
                                height: 55,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: btnEnabled
                                      ? Colors.black87
                                      : Colors.black45,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      if ((phoneController.text ==
                                                  '9898989898' ||
                                              phoneController.text ==
                                                  '9876543210') &&
                                          passwordController.text ==
                                              'password123') {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setBool('login', true);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) => Homepage()));
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Close',
                                                  ),
                                                ),
                                              ],
                                              title: Text('Error'),
                                              content: Text(
                                                  'Please enter valid credentials'),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
