import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_data.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({Key? key, required this.photoData})
      : super(key: key);

  final PhotoData photoData;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late TransformationController _transformationController;
  bool _isDarkBackground = true;
  TapDownDetails? _doubleTapDetails;
  @override
  void initState() {
    _transformationController = TransformationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkBackground ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: _isDarkBackground ? Colors.black : Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        leading:
            BackButton(color: _isDarkBackground ? Colors.white : Colors.black),
      ),
      body: Hero(
        tag: widget.photoData.id,
        child: GestureDetector(
          // Call back will be executed when user taps on the image
          // will toggle the back ground color of scaffold between black and white
          onTap: () => setState(() => _isDarkBackground = !_isDarkBackground),

          // These call backs will be executed when user double taps on the image
          // Results in zoom in and zoom out the image
          onDoubleTapDown: _handleDoubleTapDown,
          onDoubleTap: _handleDoubleTap,
          child: InteractiveViewer(
            transformationController: _transformationController,
            child: Center(
              child: AspectRatio(
                aspectRatio: widget.photoData.previewWidth /
                    widget.photoData.previewHeight,
                child: CachedNetworkImage(
                    imageUrl: widget.photoData.largeImageUrl),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }
}
