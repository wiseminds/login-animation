import 'package:common/extensions/index.dart';
import 'package:common/widgets/cached_image.dart';
import 'package:common/widgets/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({Key? key, this.slides}) : super(key: key);
  final List<String>? slides;
  final images = const [
    'https://static.toiimg.com/thumb/53110049.cms?width=1200&height=900',
    'https://c.ndtvimg.com/2020-02/tipog87_pizza_625x300_17_February_20.jpg',
    'https://www.investopedia.com/thmb/P_JZeA-MAB9JAcwQlgNbYDRsPAw=/680x453/filters:fill(auto,1)/shutterstock_225746485_pizza-5bfc44cfc9e77c0026363c3c.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Carousel(
        dotPosition: DotPosition.below,
        overlayShadowColors: context.primaryColor,
        indicatorBgPadding: 4,
        animationCurve: Curves.easeInOutQuad,
        animationDuration: const Duration(milliseconds: 700),
        dotSize: 3,
        aspectRatio: 16 / 7,
        dotBgColor: Colors.transparent,
        dotColor: context.bodyText1!.color!.withOpacity(.3),
        dotIncreasedColor: context.bodyText1!.color!,
        images: [
          if (slides == null || slides!.isEmpty)
            const CachedImage(
              url: '',
              fit: BoxFit.cover,
            )
          else
            for (var item in slides!)
              CachedImage(
                url: item,
                fit: BoxFit.cover,
              ),
        ],
      ),
    );
  }
}
