import 'dart:convert';
import 'dart:io';

import 'package:agents_app/models/common/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

Widget buildImageWidget(String id, ImageToUpload imageController, Icon icon,
    String placeholder, String? initUrl) {
  ImageToUpload imageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

  if (initUrl != null && initUrl.isNotEmpty) {
    imageController.updateLink(initUrl);
  }

  // imageControllers[id] = imageController;
  return LogoUploadWidget(
      uploadImageController: imageController,
      text: placeholder,
      icon: icon,
      validator: (value) => null);
}

class LogoUploadWidget extends StatefulWidget {
  final ImageToUpload uploadImageController;
  final String text;
  final FormFieldValidator<Object>? validator;
  final bool enabled;
  final Icon icon;

  const LogoUploadWidget(
      {super.key,
      required this.uploadImageController,
      required this.text,
      required this.validator,
      this.enabled = true,
      this.icon = const Icon(
        Icons.upload,
        color: Colors.white,
      )});

  @override
  State<LogoUploadWidget> createState() => _LogoUploadWidgetState();
}

class _LogoUploadWidgetState extends State<LogoUploadWidget> {
  final RxString controllerImage = "".obs;

  @override
  Widget build(BuildContext context) {
    final String? linkImage = widget.uploadImageController.link;
    final colorscheme = Theme.of(context).colorScheme;

    return FormField(
        validator: (value) => widget.validator!(controllerImage.value.isEmpty
            ? null
            : controllerImage.value.isEmpty),
        builder: (state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      // width: Get.width,
                      decoration: BoxDecoration(
                          color: colorscheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            widget.icon,
                          ],
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (!widget.enabled) return;

                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        String fileExtension = path.extension(pickedFile.path);
                        controllerImage.value = pickedFile.path;
                        final imageBytes = await pickedFile.readAsBytes();

                        List<int> compressedBytes =
                            await FlutterImageCompress.compressWithList(
                          imageBytes,
                          minHeight: 400,
                          minWidth: 600,
                          quality: 50,
                        );

                        String base64Image = base64Encode(compressedBytes);
                        setState(() {
                          widget.uploadImageController
                              .updateExtensionFile(fileExtension);
                          widget.uploadImageController
                              .updateBase64String(base64Image);
                        });
                      } else {
                        // No image selected.
                      }
                    },
                  ),
                  (widget.uploadImageController.needUpdate == false &&
                              linkImage != null ||
                          controllerImage.value.isNotEmpty)
                      ? IconButton(
                          onPressed: () {
                            showImageWidget(
                                context,
                                widget.uploadImageController,
                                controllerImage,
                                linkImage);
                          },
                          icon: Icon(Icons.image,
                              color: colorscheme.primary))  
                      : const SizedBox.shrink()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    state.errorText ?? "",
                    style: TextStyle(color: colorscheme.error, fontSize: 10),
                  ),
                ),
              ),
              // const SizedBox(height: 14),
            ],
          );
        });
  }
}

void showImageWidget(BuildContext context, ImageToUpload imageController,
    RxString imageBase64, String? linkImage) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imageController.needUpdate == false && linkImage != null
                ? Image.network(linkImage)
                : Obx(
                    () => Center(
                        child: imageBase64.value.isNotEmpty
                            ? Image.memory(
                                base64Decode(imageController.base64!),
                                fit: BoxFit.cover,
                                height: 600,
                                width: 600,
                              )
                            : null),
                  )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cerrar"),
          ),
        ],
      );
    },
  );
}
