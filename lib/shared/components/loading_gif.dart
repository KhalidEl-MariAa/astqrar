import 'package:flutter/material.dart';

class LoadingGif extends StatelessWidget {
  const LoadingGif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(image:AssetImage("assets/loading.gif")),
    );
  }
}
