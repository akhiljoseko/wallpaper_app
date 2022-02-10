import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/ui/widgets/loading_widget.dart';
import 'package:wallpaper_app/ui/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PagingController<int, String> _pagingController;
  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    _fetchPage(0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final newItems = ["Anil", "Akhil", "Arun", "Stefy"];
      final isLastPage = pageKey == 15;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

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
            PagedSliverGrid<int, String>(
              showNewPageProgressIndicatorAsGridChild: false,
              showNewPageErrorIndicatorAsGridChild: false,
              showNoMoreItemsIndicatorAsGridChild: false,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<String>(
                itemBuilder: (context, item, index) {
                  return Container(
                    height: 200,
                    width: 300,
                    color: Colors.red,
                    child: Text(item),
                  );
                },
                firstPageProgressIndicatorBuilder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (_, __) => const LoadingWidget(),
                  ),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 3 / 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
