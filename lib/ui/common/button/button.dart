import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:bio_auth_app/core/common/const.dart';

Color generateColor(String color) {
  switch (color) {
    case 'primary':
      return primaryColor;
    case 'danger':
      return GFColors.DANGER;
    case 'light':
      return GFColors.LIGHT;
    case 'dark':
      return Colors.black;
    case 'transparent':
      return Colors.transparent;
    default:
      return primaryColor;
  }
}

Color generateFontColor(String color) {
  switch (color) {
    case 'primary':
    case 'danger':
    case 'dark':
      return Colors.white;
    case 'light':
    case 'transparent':
      return Colors.black38;
    default:
      return Colors.white;
  }
}

// ignore: must_be_immutable
class LargeButton extends StatelessWidget {
  Function() onPressed;
  String text;
  String color;

  // ignore: use_key_in_widget_constructors
  LargeButton(
      {required this.onPressed, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return GFButton(
        onPressed: onPressed,
        text: text,
        textStyle: TextStyle(
            fontFamily: primaryFont,
            fontWeight: FontWeight.w600,
            color: generateFontColor(color)),
        color: generateColor(color),
        size: GFSize.LARGE,
        fullWidthButton: true);
  }
}

// ignore: must_be_immutable
class LargeProgressButton extends StatefulWidget {
  Function() onPressed;
  bool isProgressing = false;
  String text;
  String loadingText;
  String color;

  // ignore: use_key_in_widget_constructors
  LargeProgressButton(
      {required this.onPressed,
      required this.isProgressing,
      required this.text,
      required this.loadingText,
      required this.color});
  @override
  _LargeProgressButtonState createState() => _LargeProgressButtonState();
}

class _LargeProgressButtonState extends State<LargeProgressButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  Widget setUpButtonChild() {
    return widget.isProgressing
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    value: null,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.loadingText),
              )
            ],
          )
        : Text(widget.text);
  }

  void animateButton() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GFButton(
        onPressed: () {
          animateButton();
          widget.onPressed();
        },
        animationDuration: const Duration(milliseconds: 1000),
        child: setUpButtonChild(),
        textStyle: TextStyle(
            fontFamily: primaryFont,
            fontWeight: FontWeight.w600,
            color: generateFontColor(widget.color)),
        color: generateColor(widget.color),
        size: GFSize.LARGE,
        fullWidthButton: true);
  }
}

// ignore: must_be_immutable
class MediumButton extends StatelessWidget {
  Function() onPressed;
  String text;
  String color;

  // ignore: use_key_in_widget_constructors
  MediumButton(
      {required this.onPressed, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      textStyle:
          const TextStyle(fontFamily: primaryFont, fontWeight: FontWeight.w600),
      color: generateColor(color),
      size: GFSize.MEDIUM,
      shape: GFButtonShape.pills,
      fullWidthButton: true,
    );
  }
}

// ignore: must_be_immutable
class SmallButton extends StatelessWidget {
  Function() onPressed;
  String text;
  String color;

  // ignore: use_key_in_widget_constructors
  SmallButton(
      {required this.onPressed, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      textStyle: TextStyle(
          fontFamily: primaryFont,
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: generateFontColor(color)),
      color: generateColor(color),
      size: GFSize.SMALL,
    );
  }
}
