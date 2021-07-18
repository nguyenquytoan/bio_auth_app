import 'package:flutter/material.dart';
import 'package:bio_auth_app/core/common/const.dart';

TextAlign alignText(dir) {
  switch (dir) {
    case 'center':
      return TextAlign.center;
    default:
      return TextAlign.center;
  }
}

// ignore: must_be_immutable
class BigTitle extends StatelessWidget {
  final String text;
  final String alignment = 'center';
  late String? color = '';

  // ignore: use_key_in_widget_constructors
  BigTitle({required this.text, this.color});

  Color textColor(color) {
    switch (color) {
      case 'white':
        return Colors.white;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: alignText(alignment),
        style: TextStyle(
            color: textColor(color),
            decoration: TextDecoration.none,
            fontFamily: primaryFont,
            fontWeight: FontWeight.w600,
            fontSize: 18));
  }
}

// ignore: must_be_immutable
class SubTitle extends StatelessWidget {
  final String text;
  final String alignment = 'center';
  late String? color = '';

  // ignore: use_key_in_widget_constructors
  SubTitle({required this.text, this.color});

  Color textColor(color) {
    switch (color) {
      case 'white':
        return Colors.white70;
      default:
        return Colors.black38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignText(alignment),
      style: TextStyle(
          color: textColor(color),
          decoration: TextDecoration.none,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w600,
          fontSize: 12),
    );
  }
}

class ParagraphText extends StatelessWidget {
  final String text;
  final String alignment = 'center';

  // ignore: use_key_in_widget_constructors
  const ParagraphText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignText(alignment),
      style: const TextStyle(
          color: Colors.black87,
          decoration: TextDecoration.none,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w600,
          fontSize: 14),
    );
  }
}
