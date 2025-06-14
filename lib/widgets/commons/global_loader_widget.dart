import 'package:agents_app/controllers/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = Get.find<LoaderController>().isLoading.value;

      if (!isLoading) return SizedBox.shrink();

      return Stack(
        children: [
          // Backdrop
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
          // Loading animation centered
          Center(
            child: LoadingAnimationWidget.inkDrop(
              color: const Color(0xFF1E6091),
              size: 75,
            ),
          ),
        ],
      );
    });
  }
}
