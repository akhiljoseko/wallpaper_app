import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/services/apis/search_api.dart';

class SearchRepository {
  final SearchApi _api = SearchApi();

  Future<List<PhotoData>> getSearchResult(String params) async {
    try {
      final json = await _api.getSearchResult(params);
      final data =
          List<PhotoData>.from(json["hits"].map((e) => PhotoData.fromJson(e)));
      return data;
    } catch (error) {
      rethrow;
    }
  }
}
