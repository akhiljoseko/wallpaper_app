import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/providers/search_result_provider.dart';
import 'package:wallpaper_app/ui/widgets/loading_widget.dart';
import 'package:wallpaper_app/ui/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PagingController<int, PhotoData> _pagingController;
  late ScrollController _scrollController;
  String searchQuery = "";
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController
        .addListener(() => FocusManager.instance.primaryFocus?.unfocus());
    _pagingController = PagingController(firstPageKey: 0);
    _fetchPage(0);
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
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
      final newItems =
          await SearchResultProvider().getSearchResult(searchQuery);
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
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              stretch: true,
              expandedHeight: 150,
              elevation: 5.0,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              flexibleSpace: SearchBar(
                onSearchPressed: (query) => _updateSearchQuery(query),
              ),
            ),
            PagedSliverGrid<int, PhotoData>(
              showNewPageProgressIndicatorAsGridChild: false,
              showNewPageErrorIndicatorAsGridChild: false,
              showNoMoreItemsIndicatorAsGridChild: false,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<PhotoData>(
                itemBuilder: (context, item, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(item.webformatUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
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

  void _updateSearchQuery(String newQuery) {
    FocusManager.instance.primaryFocus?.unfocus();
    searchQuery = newQuery;
    _pagingController.refresh();
  }
}
