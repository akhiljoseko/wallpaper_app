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
  late ScrollController _scrollController;

  // Stores search query inout from the user
  String _searchQuery = "";

  // Decides whether FAB should display or not
  bool _showFAB = false;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _handleFAB();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// This function initiate an api call to fetch search result from api
  ///
  /// Controls pagination by appending new pages an caching old data internally
  ///
  /// If error is occured while fetching data error will be assigned to the controller
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await SearchResultProvider().getSearchResult(_searchQuery, pageKey);
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
      // Shows FAB only if _showFAB is true
      floatingActionButton: _showFAB
          ? FloatingActionButton.extended(
              // This call back will programatically scrolls the page to top
              onPressed: () {
                _scrollController.animateTo(0.00,
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.easeOutSine);
              },
              label: const Text("Top"),
              icon: const Icon(Icons.arrow_upward),
            )
          : null,
      body: SafeArea(
        child: NotificationListener<ScrollUpdateNotification>(
          // This call back will be executed whenever user starts scrolling
          // This will hide the key board by removing focus from the search bar
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
            controller: _scrollController,
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
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Lets get some wallpapers",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
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

                      // Executes when user taps on a image in home screen
                      // First removes focus if any means hide keyboard
                      // Then will navigate to image view screen
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            return ImagePreviewScreen(photoData: item);
                          },
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

  /// Function to update search query
  ///
  /// This will be called whenever user taps on search icon or tapping on the [TextInputAction]
  ///
  /// [newQuery] - A string input taken from user input in search box
  void _updateSearchQuery(String newQuery) {
    FocusManager.instance.primaryFocus?.unfocus();
    _searchQuery = newQuery;
    _pagingController.refresh();
  }

  /// Fuction to control FAB state
  ///
  /// sets and resets the variable [_showFAB] hence will display or hide the FAB
  ///
  /// [_showFAB] - will be set to true if user scrolls greater than 400dp and vice versa
  void _handleFAB() {
    if (_scrollController.offset > 400.0) {
      setState(() {
        _showFAB = true;
      });
    } else {
      setState(() {
        _showFAB = false;
      });
    }
  }
}
