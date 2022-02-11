import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/models/photo_data.dart';
import 'package:wallpaper_app/providers/search_result_provider.dart';
import 'package:wallpaper_app/ui/screens/image_screen.dart';
import 'package:wallpaper_app/ui/widgets/full_screen_error_widget.dart';
import 'package:wallpaper_app/ui/widgets/full_screen_loading_widget.dart';
import 'package:wallpaper_app/ui/widgets/image_preview_container.dart';
import 'package:wallpaper_app/ui/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PagingController<int, PhotoData> _pagingController;
  String searchQuery = "";
  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 1);
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
      final newItems =
          await SearchResultProvider().getSearchResult(searchQuery, pageKey);
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
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
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollUpdateNotification notification) {
            final FocusScopeNode focusScope = FocusScope.of(context);
            if (notification.dragDetails != null &&
                focusScope.hasFocus &&
                notification.scrollDelta! > 10.0) {
              focusScope.unfocus();
            }
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi there,",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Lets get some wallpapers",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      SearchBar(onSearchPressed: (s) => _updateSearchQuery(s)),
                    ],
                  ),
                ),
              ),
              PagedSliverGrid<int, PhotoData>(
                showNewPageProgressIndicatorAsGridChild: false,
                showNewPageErrorIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<PhotoData>(
                  itemBuilder: (context, item, index) {
                    return ImagePreviewContainer(
                      photoData: item,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImagePreviewScreen(photoData: item),
                        ),
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) =>
                      const FullScreenLoadingWidget(),
                  firstPageErrorIndicatorBuilder: (context) =>
                      FullScreenErrorWidget(
                    onRetryPressed: () =>
                        _pagingController.retryLastFailedRequest(),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
              ),
            ],
          ),
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
