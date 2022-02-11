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
      body: Hero(
        tag: widget.photoData.id,
        child: GestureDetector(
          onTap: () => setState(() => _isDarkBackground = !_isDarkBackground),
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
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        // ..translate(-position.dx * 2, -position.dy * 2)
        // ..scale(3.0);
        // Fox a 2x zoom
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }
}
