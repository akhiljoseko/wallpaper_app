import 'package:json_annotation/json_annotation.dart';

part 'photo_data.g.dart';

@JsonSerializable()
class PhotoData {
  PhotoData({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.previewUrl,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatUrl,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageUrl,
  });

  final int id;
  @JsonKey(name: "pageURL")
  final String pageUrl;
  final String type;
  final String tags;
  @JsonKey(name: "previewURL")
  final String previewUrl;
  final int previewWidth;
  final int previewHeight;
  @JsonKey(name: "webformatURL")
  final String webformatUrl;
  final int webformatWidth;
  final int webformatHeight;
  @JsonKey(name: "largeImageURL")
  final String largeImageUrl;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int collections;
  final int likes;
  final int comments;
  @JsonKey(name: "user_id")
  final int userId;
  final String user;
  @JsonKey(name: "userImageURL")
  final String userImageUrl;

  factory PhotoData.fromJson(Map<String, dynamic> json) =>
      _$PhotoDataFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoDataToJson(this);
}
