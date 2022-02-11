import 'package:flutter/material.dart';

class FullScreenErrorWidget extends StatelessWidget {
  const FullScreenErrorWidget({
    Key? key,
    required this.onRetryPressed,
  }) : super(key: key);
  final VoidCallback onRetryPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset("assets/images/error_illustration.png"),
            ),
            Text(
              "Oops!",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text("Something went wrong",
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onRetryPressed,
              child: Text(
                "Retry",
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 50)),
            )
          ],
        ),
      ),
    );
  }
}
