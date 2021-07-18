import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:bio_auth_app/core/common/const.dart';
import 'package:bio_auth_app/ui/modules/pages/get_started/get_started.dart';
import 'package:bio_auth_app/ui/modules/pages/login/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BioAuthApp());
}

class BioAuthApp extends StatelessWidget {
  const BioAuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MainScreen(), theme: ThemeData(fontFamily: primaryFont));
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AfterLayoutMixin<MainScreen> {
  Future checkFirstSeen() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool _firstSeen = (_prefs.getBool('seen') ?? false);

    if (_firstSeen) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } else {
      var uuid = const Uuid();
      String id = uuid.v4().split('-').join();
      await _prefs.setBool('seen', true);
      await _prefs.setString('id', id);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => GetStarted()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
