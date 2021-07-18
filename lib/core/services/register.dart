import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bio_auth_app/core/common/const.dart';

Future<String> getFaceID() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  Uri apiUrl = Uri.parse(url + 'get?id=' + (_prefs.getString('id')).toString());
  var request = http.MultipartRequest('GET', apiUrl);

  var response = await request.send();
  var resStr = await http.Response.fromStream(response);

  return resStr.body;
}

Future<String> deleteFaceID() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  Uri apiUrl = Uri.parse(url + 'delete');
  var request = http.MultipartRequest('DELETE', apiUrl)
    ..fields['id'] = (_prefs.getString('id')).toString();

  var response = await request.send();
  var resStr = await http.Response.fromStream(response);

  return resStr.body;
}

Future<String> register(listOfFilePath) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  Uri apiUrl = Uri.parse(url + 'upload');
  var request = http.MultipartRequest('POST', apiUrl)
    ..fields['id'] = (_prefs.getString('id')).toString();

  for (var i = 0; i < listOfFilePath.length; i++) {
    request.files.add(await http.MultipartFile.fromPath(
        'images', listOfFilePath[i],
        filename: listOfFilePath[i].split('/').last,
        contentType: MediaType('multipart', 'form-data')));
  }

  var response = await request.send();
  var resStr = await http.Response.fromStream(response);

  return resStr.body;
}

Future<String> cancelRegister() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  Uri apiUrl = Uri.parse(url + 'cancel');
  var request = http.MultipartRequest('DELETE', apiUrl)
    ..fields['id'] = (_prefs.getString('id')).toString();

  var response = await request.send();
  var resStr = await http.Response.fromStream(response);

  return resStr.body;
}
