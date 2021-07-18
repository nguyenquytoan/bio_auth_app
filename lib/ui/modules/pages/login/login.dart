import 'package:flutter/material.dart';
import 'package:bio_auth_app/ui/common/button/button.dart';
import 'package:bio_auth_app/ui/common/text/text.dart';
import 'package:bio_auth_app/ui/modules/pages/register/register.dart';
import 'package:bio_auth_app/ui/modules/pages/login/login_with_faceid.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                height: mediaQueryData.size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg-login.jpg'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: mediaQueryData.size.height * 0.02),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: BigTitle(text: 'Welcome')),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SubTitle(
                                      text: 'Please sign in to continue'),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  32.0,
                                  mediaQueryData.size.height * 0.02,
                                  32.0,
                                  20.0),
                              child: LargeButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginWithFaceID()));
                                  },
                                  text: 'Scan with Face ID',
                                  color: 'primary'),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      mediaQueryData.size.height * 0.02,
                                      0,
                                      mediaQueryData.size.height * 0.036),
                                  child: Column(
                                    children: [
                                      SubTitle(
                                          text:
                                              "If you don't have an account, register here"),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            32.0,
                                            mediaQueryData.size.height * 0.02,
                                            32.0,
                                            0.0),
                                        child: LargeButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Register()));
                                            },
                                            text: 'Add Biometrics',
                                            color: 'primary'),
                                      )
                                    ],
                                  )))
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
