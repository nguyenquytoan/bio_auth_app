import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bio_auth_app/core/common/const.dart';

Future<String> authenticate(filePath) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  Uri apiUrl = Uri.parse(url + 'predict');
  var request = http.MultipartRequest('POST', apiUrl)
    ..fields['id'] = (_prefs.getString('id')).toString()
    ..files.add(await http.MultipartFile.fromPath('image', filePath,
        filename: filePath.split('/').last,
        contentType: MediaType('multipart', 'form-data')));

  var response = await request.send();
  var resStr = await http.Response.fromStream(response);

  return resStr.body;
}
