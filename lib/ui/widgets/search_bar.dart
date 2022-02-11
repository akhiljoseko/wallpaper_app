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
      decoration: ShapeDecoration(
          shape: const StadiumBorder(), color: Colors.grey[200]),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Happy face, Music, Nature",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey),
                  border: InputBorder.none,
                  suffix: GestureDetector(
                    onTap: () {
                      _controller.clear();
                      widget.onSearchPressed(_controller.text);
                    },
                    child: Text(
                      "Clear",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    widget.onSearchPressed(_controller.text);
                  }
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onSearchPressed(_controller.text);
                }
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
