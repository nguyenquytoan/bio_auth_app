import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bio_auth_app/ui/common/button/button.dart';
import 'package:bio_auth_app/ui/common/text/text.dart';
import 'package:bio_auth_app/ui/modules/pages/register/register_with_faceid.dart';
import 'package:bio_auth_app/core/services/register.dart';

// ignore: use_key_in_widget_constructors
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isButtonLoading = false;
  bool hasFaceID = false;
  bool canRegister = false;
  String faceIDCard = 'Add Face ID';

  void getFaceIDFromApi() async {
    var response = await getFaceID();
    var code = int.parse(json.decode(response)['code']);

    switch (code) {
      case 0:
        setState(() {
          hasFaceID = true;
          faceIDCard = 'Face ID Detected';
        });
        break;
      case 1:
        setState(() {
          hasFaceID = false;
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    getFaceIDFromApi();
    super.initState();
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SmallButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              text: 'Cancel',
                              color: 'transparent')),
                    ),
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
                                    child: BigTitle(text: 'Create an account')),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SubTitle(text: 'Add biometrics'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Card(
                                child: ListTile(
                                    leading: hasFaceID
                                        ? const Icon(Icons.check_circle_rounded)
                                        : const Icon(Icons.add_circle_outline),
                                    title: Align(
                                        alignment: Alignment.topLeft,
                                        child: ParagraphText(text: faceIDCard)),
                                    trailing: const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black38),
                                    onTap: () async {
                                      if (hasFaceID) {
                                        await deleteFaceID();
                                      }

                                      final result = await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterWithFaceID()));

                                      result
                                          ? setState(() {
                                              hasFaceID = true;
                                              canRegister = true;
                                              faceIDCard = 'Face ID Detected';
                                            })
                                          : setState(() {
                                              hasFaceID = false;
                                              faceIDCard = 'Add Face ID';
                                            });
                                    })),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                32.0,
                                mediaQueryData.size.height * 0.04,
                                32.0,
                                mediaQueryData.size.width * 0.08),
                            child: canRegister
                                ? LargeProgressButton(
                                    isProgressing: isButtonLoading,
                                    loadingText: 'Registering...',
                                    onPressed: () {
                                      setState(() {
                                        isButtonLoading = true;
                                      });

                                      Timer(const Duration(milliseconds: 2000),
                                          () {
                                        setState(() {
                                          isButtonLoading = false;
                                        });
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      });
                                    },
                                    text: 'Register',
                                    color: 'primary')
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06),
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
