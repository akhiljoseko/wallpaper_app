import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/services/apis/search_api.dart';

/// Repository class for handling network calls and errors to search api. Also
/// parses data returned from the API call
class SearchRepository {
  final SearchApi _api = SearchApi();

  /// This Function will handle the calls into search api
  ///
  /// Parses data and returns a [List] of [PhotoData] for successful API calls
  ///
  /// Catching errors occuring in API calls and Json Parsing and rethrows them
  ///
  /// [params] - URL params to the API
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
