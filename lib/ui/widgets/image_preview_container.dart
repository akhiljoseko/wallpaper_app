import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/ui/widgets/loading_widget.dart';

class ImagePreviewContainer extends StatelessWidget {
  const ImagePreviewContainer({
    Key? key,
    required this.photoData,
    required this.onTap,
  }) : super(key: key);

  final PhotoData photoData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: photoData.id,
      child: GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: photoData.largeImageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, progress) =>
              const LoadingWidget(),
        ),
      ),
    );
  }
}
