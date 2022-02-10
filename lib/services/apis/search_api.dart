import 'package:wallpaper_app/services/apis/base_api.dart';

class SearchApi extends BaseApi {
  Future<dynamic> getSearchResult(String params) async {
    return await super.get(params);
  }
}
