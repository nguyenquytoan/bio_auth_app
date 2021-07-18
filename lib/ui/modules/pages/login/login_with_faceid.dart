import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:camera/camera.dart';
import 'package:bio_auth_app/ui/common/button/button.dart';
import 'package:bio_auth_app/ui/common/text/text.dart';
import 'package:bio_auth_app/core/services/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithFaceID extends StatefulWidget {
  const LoginWithFaceID({Key? key}) : super(key: key);

  @override
  _LoginWithFaceIDState createState() => _LoginWithFaceIDState();
}

class _LoginWithFaceIDState extends State<LoginWithFaceID> {
  bool waitForVerify = true;
  bool isVerified = false;
  String bigTitle = 'Face ID Verification';
  String subTitle = 'Please put your phone in front of your face';
  String anotherSubTitle = 'and press the button below';

  // Camera Initialized
  late CameraController _camera;
  final CameraLensDirection _direction = CameraLensDirection.front;
  bool _cameraInitialized = false;

  Future<CameraDescription> _getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  void _initializeCamera() async {
    _camera = CameraController(
        await _getCamera(_direction), ResolutionPreset.veryHigh);
    _camera.initialize().then((_) {
      setState(() {
        _cameraInitialized = true;
      });
    });
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _camera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
          height: mediaQueryData.size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: SmallButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Cancel',
                            color: 'dark')),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: mediaQueryData.size.height * 0.08),
                    child: (_cameraInitialized)
                        ? AspectRatio(
                            aspectRatio: 1,
                            child: Transform.scale(
                              scale: 1 / _camera.value.aspectRatio,
                              child: ClipOval(
                                  child: AspectRatio(
                                aspectRatio: _camera.value.aspectRatio,
                                child: CameraPreview(_camera),
                              )),
                            ),
                          )
                        : const AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: GFLoader(
                                  type: GFLoaderType.circle,
                                  size: GFSize.LARGE),
                            )),
                  ),
                  BigTitle(text: bigTitle, color: 'white'),
                  SubTitle(text: subTitle, color: 'white'),
                  SubTitle(text: anotherSubTitle, color: 'white'),
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      32.0,
                      mediaQueryData.size.height * 0.04,
                      32.0,
                      mediaQueryData.size.width * 0.08),
                  child: waitForVerify
                      ? LargeButton(
                          onPressed: () async {
                            SharedPreferences _prefs =
                                await SharedPreferences.getInstance();

                            setState(() {
                              waitForVerify = false;
                              bigTitle = 'Face ID Scanning...';
                              subTitle =
                                  'Please put your phone in front of your face';
                              anotherSubTitle =
                                  _prefs.getString('id').toString();
                            });

                            try {
                              final image = await _camera.takePicture();
                              var response = await authenticate(image.path);
                              var code =
                                  int.parse(json.decode(response)['code']);
                              String msg = '';

                              switch (code) {
                                case 0:
                                  msg = 'Successful';
                                  break;
                                case 1:
                                  msg = 'Please register before verification';
                                  break;
                                case 4:
                                  msg = 'Failed';
                                  break;
                                default:
                                  break;
                              }

                              setState(() {
                                bigTitle = msg;
                                subTitle = '';
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          text: 'Start',
                          color: 'primary')
                      : isVerified
                          ? LargeButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: 'Back',
                              color: 'primary')
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06))
            ],
          ),
        )));
  }
}
