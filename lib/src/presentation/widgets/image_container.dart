import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:iconsax/iconsax.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {required this.image,
      required this.onImageTap,
      required this.onImageDelete,
      super.key});

  final Uint8List? image;
  final void Function() onImageTap;
  final void Function() onImageDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 240.0),
      child: Stack(
        children: [
          Ink(
            width: double.infinity,
            height: 240.0,
            decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                  BorderSide(color: HeyDoDoColors.medium),
                ),
                borderRadius: BorderRadius.circular(24.0)),
            child: InkWell(
                onTap: onImageTap,
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.memory(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.image,
                            size: 32.0,
                            color: HeyDoDoColors.medium,
                          ),
                          SizedBox(
                            height: heyDoDoPadding * 3,
                          ),
                          Text(
                            'Agregar imagen',
                            style: TextStyle(
                                color: HeyDoDoColors.medium,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )),
          ),
          if (image != null)
            Positioned(
                top: 3.5,
                right: 7.0,
                child: GestureDetector(
                  onTap: onImageDelete,
                  child: Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                        color: HeyDoDoColors.white.withOpacity(.85),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: HeyDoDoColors.white.withOpacity(.35),
                              blurRadius: 4.0,
                              offset: const Offset(1.0, 2.5))
                        ]),
                    child: const Icon(
                      Icons.close,
                      size: 18.0,
                      color: HeyDoDoColors.medium,
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
