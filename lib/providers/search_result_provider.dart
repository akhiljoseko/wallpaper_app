import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/services/repository/search_repository.dart';

class SearchResultProvider extends ChangeNotifier {
  final SearchRepository _repository = SearchRepository();
  Future<List<PhotoData>> getSearchResult(String query, int pageNumber) async {
    try {
      String params = "";
      final encodedQuery = Uri.encodeComponent(query);
      params = _addToParams(params, "q", encodedQuery);
      params = _addToParams(params, "image_type", "photo");
      params = _addToParams(params, "page", "$pageNumber");
      final data = await _repository.getSearchResult(params);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  String _addToParams(
      String currentParams, String newParam, String paramValue) {
    if (paramValue.isEmpty) {
      return currentParams;
    } else {
      return currentParams + "&" + "$newParam=$paramValue";
    }
  }
}
