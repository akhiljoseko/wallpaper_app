import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/widgets/loading_widget.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  const FullScreenLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (_, __) => const LoadingWidget(),
      ),
    );
  }
}
