import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/services/repository/search_repository.dart';

class SearchResultProvider extends ChangeNotifier {
  final SearchRepository _repository = SearchRepository();
  Future<List<PhotoData>> getSearchResult(String query) async {
    try {
      String params = "";
      final encodedQuery = Uri.encodeComponent(query);
      params = _addToParams(params, "q", encodedQuery);
      params = _addToParams(params, "image_type", "photo");
      final data = await _repository.getSearchResult(params);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  String _addToParams(String currentParams, newParam, paramValue) {
    return currentParams + "&" + "$newParam=$paramValue";
  }
}
