import 'package:common/common.dart';
import 'package:common/constants/svg_strings.dart';
import 'package:customer/constants/image_assets.dart';
import 'package:flutter/material.dart';

class AuthGridHeader extends StatelessWidget {
  final bool alternate;
  const AuthGridHeader({Key? key, this.alternate = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double side = (MediaQuery.of(context).size.width + 20) / 3;
    ShapeBorder shape = RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(3));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spring.slide(
                slideType: SlideType.slide_in_right,
                delay: const Duration(milliseconds: 300),
                child: Material(
                  shape: shape,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 207,
                    width: side,
                    child: Image.asset(ImageAssets.image1, fit: BoxFit.cover),
                  ),
                )),
            10.0.h,
            Spring.slide(
                slideType: SlideType.slide_in_left,
                withFade: true,
                delay: const Duration(milliseconds: 200),
                child: Material(
                  shape: shape,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                      height: 180,
                      width: side,
                      child:
                          Image.asset(ImageAssets.image4, fit: BoxFit.cover)),
                ))
          ],
        ),
        10.0.w,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spring.slide(
                slideType: SlideType.slide_in_top,
                // cutomTweenOffset:
                //     Tween(begin: const Offset(0, 100), end: const Offset(0, 0)),
                delay: const Duration(milliseconds: 700),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  shape: shape,
                  child: SizedBox(
                    height: 169,
                    width: side,
                    child:
                        Image.asset(ImageAssets.image2, fit: BoxFit.fitHeight),
                  ),
                )),
            if (!alternate)
              Spring.fadeIn(
                  delay: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      19.0.h,
                      SizedBox.square(
                          dimension: 50,
                          child: SvgPicture.string(SvgStrings.CITI_SQUARE)),
                      8.0.h,
                      const Text('CITISQUARE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 3)),
                      19.0.h,
                    ],
                  ))
            else
              10.0.h,
            Spring.slide(
                slideType: SlideType.slide_in_bottom,
                withFade: true,
                cutomTweenOffset:
                    Tween(begin: const Offset(0, 100), end: const Offset(0, 0)),
                delay: const Duration(milliseconds: 700),
                child: Material(
                  shape: shape,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 200,
                    width: side,
                    child: Image.asset(ImageAssets.image5, fit: BoxFit.cover),
                  ),
                ))
          ],
        ),
        10.0.w,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spring.slide(
                slideType: SlideType.slide_in_left,
                delay: const Duration(milliseconds: 300),
                child: Material(
                  shape: shape,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 182,
                    width: side,
                    child: Image.asset(ImageAssets.image3, fit: BoxFit.cover),
                  ),
                )),
            10.0.h,
            Spring.slide(
                slideType: SlideType.slide_in_right,
                withFade: true,
                delay: const Duration(milliseconds: 400),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  shape: shape,
                  child: SizedBox(
                    height: 209,
                    width: side,
                    child: Image.asset(ImageAssets.image6, fit: BoxFit.cover),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
