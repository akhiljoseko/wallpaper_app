import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

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
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10),
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       "Go",
            //       style: Theme.of(context).textTheme.button?.copyWith(
            //           color: Colors.black, fontWeight: FontWeight.w700),
            //     ),
            //     style: TextButton.styleFrom(
            //       shape: StadiumBorder(),
            //       backgroundColor: Colors.green[200],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
