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
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text("Something went wrong",
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onRetryPressed,
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 50)),
              child: Text(
                "Retry",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
