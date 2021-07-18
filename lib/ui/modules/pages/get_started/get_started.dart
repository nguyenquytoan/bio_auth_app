import 'package:flutter/material.dart';
import 'package:bio_auth_app/ui/common/button/button.dart';
import 'package:bio_auth_app/ui/common/text/text.dart';
import 'package:bio_auth_app/ui/modules/pages/login/login.dart';

// ignore: use_key_in_widget_constructors
class GetStarted extends StatelessWidget {
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
                        image: AssetImage('assets/bg-gs.jpg'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(32.0,
                                  mediaQueryData.size.height * 0.05, 0, 0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SubTitle(text: 'Welcome to')),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: BigTitle(
                                      text: 'Biometrics Authentication')),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(32.0, 0, 0, 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: BigTitle(text: 'Application')),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0,
                                  mediaQueryData.size.height * 0.05),
                              child: ListTile(
                                title: Align(
                                  alignment: Alignment.topLeft,
                                  child: SubTitle(
                                      text:
                                          'Try out different ways to authentication'),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.topLeft,
                                  child: SubTitle(
                                      text: 'Explore everything with us'),
                                ),
                                trailing: SmallButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    text: 'Get Started',
                                    color: 'primary'),
                              ),
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
