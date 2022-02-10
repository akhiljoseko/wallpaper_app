import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/services/apis/exception.dart';

class BaseApi {
  final _baseUrl = "https://pixabay.com/api/";
  final _apiKey = "25624889-24abcab269e9b31f4a309559a";

  Future<dynamic> get(String params) async {
    String url = _baseUrl + "?key=$_apiKey&" + params;
    final response = await http.get(Uri.parse(url));
    return _getResponse(response);
  }

  _getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
      case 204:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      default:
        throw InternalServerErrorException(response.body.toString());
    }
  }
}
