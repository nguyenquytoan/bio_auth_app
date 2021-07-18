import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:camera/camera.dart';
import 'package:bio_auth_app/ui/common/button/button.dart';
import 'package:bio_auth_app/ui/common/text/text.dart';
import 'package:bio_auth_app/core/services/register.dart';

class RegisterWithFaceID extends StatefulWidget {
  const RegisterWithFaceID({Key? key}) : super(key: key);

  @override
  _RegisterWithFaceIDState createState() => _RegisterWithFaceIDState();
}

class _RegisterWithFaceIDState extends State<RegisterWithFaceID> {
  double progressValue = 0;
  bool waitForRegister = true;
  bool isRegistered = false;
  String bigTitle = 'Face ID Register';
  String subTitle = 'Please put your phone in front of your face';
  String anotherSubTitle = 'and press the button below';
  bool breakLoop = false;

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
    _camera.initialize().then((_) async {
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
                            onPressed: () async {
                              await cancelRegister();
                              breakLoop = true;
                              Navigator.of(context).pop(false);
                            },
                            text: 'Cancel',
                            color: 'dark')),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: mediaQueryData.size.height * 0.08),
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          startAngle: 270,
                          endAngle: 270,
                          radiusFactor: 0.8,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.05,
                            color: Color.fromARGB(30, 0, 169, 181),
                            thicknessUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.startCurve,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: progressValue,
                                width: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                enableAnimation: true,
                                animationDuration: 100,
                                animationType: AnimationType.linear,
                                cornerStyle: CornerStyle.startCurve,
                                gradient: const SweepGradient(colors: <Color>[
                                  Color(0xFF00a9b5),
                                  Color(0xFFa4edeb)
                                ], stops: <double>[
                                  0.25,
                                  0.75
                                ])),
                            MarkerPointer(
                              value: progressValue,
                              markerType: MarkerType.circle,
                              enableAnimation: true,
                              animationDuration: 100,
                              animationType: AnimationType.linear,
                              color: const Color(0xFF87e8e8),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0,
                                widget: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: (_cameraInitialized)
                                      ? Padding(
                                          padding: EdgeInsets.all(
                                              mediaQueryData.size.height *
                                                  0.01),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Transform.scale(
                                              scale:
                                                  1 / _camera.value.aspectRatio,
                                              child: ClipOval(
                                                child: AspectRatio(
                                                  aspectRatio:
                                                      _camera.value.aspectRatio,
                                                  child: CameraPreview(_camera),
                                                ),
                                              ),
                                            ),
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
                                ))
                          ]),
                    ]),
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
                  child: waitForRegister
                      ? LargeButton(
                          onPressed: () async {
                            setState(() {
                              waitForRegister = false;
                              bigTitle = 'Face ID Registering...';
                              subTitle =
                                  'Please put your phone in front of your face';
                              anotherSubTitle =
                                  'and rotate your head clockwise slowly';
                            });

                            while (progressValue < 100) {
                              if (breakLoop) break;

                              try {
                                var listOfImages = [];
                                for (int i = 0; i < 2; i++) {
                                  final image = await _camera.takePicture();
                                  listOfImages.add(image.path);
                                }

                                var response = await register(listOfImages);
                                var code =
                                    int.parse(json.decode(response)['code']);

                                // Check response
                                if (code == 0) {
                                  setState(() {
                                    progressValue += 20;
                                  });
                                }
                              } catch (e) {
                                print(e);
                              }
                            }

                            setState(() {
                              isRegistered = true;
                              bigTitle = 'Register Successfully';
                              subTitle =
                                  'Please press the button below to finish';
                              anotherSubTitle = '';
                            });
                          },
                          text: 'Start',
                          color: 'primary')
                      : isRegistered
                          ? LargeButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              text: 'Register',
                              color: 'primary')
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06))
            ],
          ),
        )));
  }
}
