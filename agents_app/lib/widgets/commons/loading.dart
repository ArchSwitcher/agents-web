import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final bool isLoading;
  const Loading({super.key, required this.isLoading});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container();
    }

    return CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
    );
  }
}
