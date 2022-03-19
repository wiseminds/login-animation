import 'dart:io';

import 'package:common/services/citi_image_picker_service.dart';
import 'package:common/widgets/cached_image.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';

class CustomerImagePicker extends StatelessWidget {
  final Function(String path) onChanged;
  final String? path;
  final BoxFit? fit;
  final double ratioX, ratioY;
  final bool lockAspectRatio;
  const CustomerImagePicker({
    Key? key,
    required this.onChanged,
    this.path,
    this.fit,
    this.ratioX = 1,
    this.ratioY = 1,
    this.lockAspectRatio = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (Theme.of(context).textTheme.bodyText1?.color ?? Colors.grey)
            .withOpacity(.2),
        borderRadius: 10.0.toBorderRadius,
        // shape: Shape.box
      ),
      child: path != null
          ? Material(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: path!.contains('http')
                          ? CachedImage(
                              url: path!,
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                              height: 150,
                              width: 150,
                            )
                          : Image.file(File(path!),
                              fit: fit, height: 150, width: 150),
                    ),
                  ),
                  600.0.w,
                  Positioned(
                      bottom: 0,
                      right: 10,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: 8.5.toBorderRadius)),
                            backgroundColor: MaterialStateProperty.all(
                                context.backgroundColor)),
                        onPressed: () => _pickImage(context),
                        child: Text('Change Image',
                            style: context.caption?.copyWith(
                                fontSize: 10.5,
                                color: Colors.red,
                                fontWeight: FontWeight.w700)),
                      ))
                ],
              ),
            )
          : TextButton(
              onPressed: () => _pickImage(context),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    600.0.w,
                    Material(
                      color: const Color(0xff4C536A).withOpacity(.35),
                      shape: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    20.0.h,
                    Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: 6.0.toBorderRadius,
                            side: BorderSide(
                                color: (Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color ??
                                        Colors.grey)
                                    .withOpacity(.2))),
                        color: context.isDark ? Colors.black : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Upload Photo'),
                        )),
                  ],
                ),
              ),
            ),
    );
  }

  _pickImage(BuildContext context) async {
    var path =
        await const CitiImagePickerService(source: CitiImageSource.gallery)
            .getImage(context,
                ratioX: ratioX,
                ratioY: ratioY,
                lockAspectRatio: lockAspectRatio);
    if (path != null) onChanged(path);
  }
}
