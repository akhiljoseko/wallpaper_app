import 'package:wallpaper_app/services/apis/base_api.dart';

/// API class for handling calls to search api
class SearchApi extends BaseApi {
  Future<dynamic> getSearchResult(String params) async {
    return await super.get(params);
  }
}
