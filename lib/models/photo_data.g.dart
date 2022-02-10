// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoData _$PhotoDataFromJson(Map<String, dynamic> json) => PhotoData(
      id: json['id'] as int,
      pageUrl: json['pageUrl'] as String,
      type: json['type'] as String,
      tags: json['tags'] as String,
      previewUrl: json['previewUrl'] as String,
      previewWidth: json['previewWidth'] as int,
      previewHeight: json['previewHeight'] as int,
      webformatUrl: json['webformatUrl'] as String,
      webformatWidth: json['webformatWidth'] as int,
      webformatHeight: json['webformatHeight'] as int,
      largeImageUrl: json['largeImageUrl'] as String,
      imageWidth: json['imageWidth'] as int,
      imageHeight: json['imageHeight'] as int,
      imageSize: json['imageSize'] as int,
      views: json['views'] as int,
      downloads: json['downloads'] as int,
      collections: json['collections'] as int,
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      userId: json['userId'] as int,
      user: json['user'] as String,
      userImageUrl: json['userImageUrl'] as String,
    );

Map<String, dynamic> _$PhotoDataToJson(PhotoData instance) => <String, dynamic>{
      'id': instance.id,
      'pageUrl': instance.pageUrl,
      'type': instance.type,
      'tags': instance.tags,
      'previewUrl': instance.previewUrl,
      'previewWidth': instance.previewWidth,
      'previewHeight': instance.previewHeight,
      'webformatUrl': instance.webformatUrl,
      'webformatWidth': instance.webformatWidth,
      'webformatHeight': instance.webformatHeight,
      'largeImageUrl': instance.largeImageUrl,
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'imageSize': instance.imageSize,
      'views': instance.views,
      'downloads': instance.downloads,
      'collections': instance.collections,
      'likes': instance.likes,
      'comments': instance.comments,
      'userId': instance.userId,
      'user': instance.user,
      'userImageUrl': instance.userImageUrl,
    };
