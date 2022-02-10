import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              stretch: true,
              expandedHeight: 150,
              elevation: 5.0,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              flexibleSpace: SearchBar(),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.red,
                height: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.red,
                height: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.red,
                height: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.red,
                height: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.red,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
