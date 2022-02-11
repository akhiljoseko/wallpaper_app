import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.onSearchPressed}) : super(key: key);

  final void Function(String) onSearchPressed;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Card(
        shape: const StadiumBorder(),
        elevation: 3.0,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) =>
                      widget.onSearchPressed(_controller.text)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                onPressed: () => widget.onSearchPressed(_controller.text),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
