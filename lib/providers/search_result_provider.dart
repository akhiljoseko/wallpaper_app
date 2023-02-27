import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/services/repository/search_repository.dart';

/// A class for handlind state and functions related to searching photos form
///  https://pixabay.com/api/
class SearchResultProvider extends ChangeNotifier {
  final SearchRepository _repository = SearchRepository();

  /// This function will return a [List] of [PhotoData] those are fetched from
  ///  https://pixabay.com/api/
  ///
  /// Function body will encode search query provided by user in search box
  /// and add some other params to the url
  ///
  /// Throws errors if any enocountered while connecting or parsing data from API
  Future<List<PhotoData>> getSearchResult(String query, int pageNumber) async {
    try {
      String params = "";
      final encodedQuery = Uri.encodeComponent(query);
      params = _addToParams(params, "q", encodedQuery);
      params = _addToParams(params, "image_type", "photo");
      params = _addToParams(params, "page", "$pageNumber");
      params = _addToParams(params, "orientation", "vertical");
      final data = await _repository.getSearchResult(params);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  /// Function for adding extra params to the url
  ///
  /// [currentUrl] - Current url that can be modified with other params or empty
  ///
  /// [newParam] - Name of new param, names can be found in this [ API documentation](https://pixabay.com/api/docs/)
  ///
  /// [paramValue] - Value of corresponding param, default and accepted values are also
  /// given in [API documentation](https://pixabay.com/api/docs/)
  String _addToParams(String currentUrl, String newParam, String paramValue) {
    if (paramValue.isEmpty) {
      return currentUrl;
    } else {
      return "$currentUrl&$newParam=$paramValue";
    }
  }
}
