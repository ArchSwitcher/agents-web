import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

    return LoadingAnimationWidget.stretchedDots(
      color: Theme.of(context).colorScheme.primary,
      size: 50,
    );
  }
}
