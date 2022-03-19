import 'package:common/common.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/constants/image_assets.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/back.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget implements AppRoute {
  const AboutScreen({Key? key}) : super(key: key);

  static String get routeName => 'about-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;

  @override
  Widget build(BuildContext context) {
    return Material(
        // color: context.backgroundColor,
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.PADDING_SMALL),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dimens.PADDING_SMALL.h,
                      Row(
                        children: [
                          const Back(),
                          Text(
                            'About',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      30.0.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            child: Image.asset(
                              ImageAssets.LOGO,
                              package: 'common',
                            ),
                          ),
                          10.0.w,
                          Text(
                            'CITISQUARE',
                            style: context.headline5
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      30.0.h,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vehicula nisl a ornare volutpat. Curabitur vestibulum nulla tellus, ut eleifend nibh maximus hendrerit. Nullam eu gravida enim, et lobortis lorem. Sed lobortis mi eget mollis accumsan. Vestibulum ut lacinia tortor. Praesent dictum elit sed sem accumsan, eu tristique tortor eleifend. Etiam porta blandit nulla id cursus. Aliquam erat volutpat.
                    
                    Sed tristique felis massa, eget elementum nibh finibus quis. Aliquam vitae maximus nisi. Sed ullamcorper odio tellus, id tempus justo tincidunt cursus. Aenean interdum, neque vitae auctor iaculis, dui tortor consequat sapien, vitae interdum metus felis eget nulla. Nunc sit amet eros malesuada urna tempor ornare. Vestibulum mauris tellus, bibendum id eros eget, rutrum porttitor eros. Sed facilisis sem a lorem ornare, posuere congue est dapibus. Vivamus facilisis lacinia massa. Donec vel arcu urna. Integer mollis diam magna, eu iaculis nibh scelerisque at.
                    
                    App version • 1.0     |     Released • Jul 12, 2020''',
                            textAlign: TextAlign.justify,
                            style: context.bodyText1
                                ?.copyWith(fontSize: 13, height: 1.7),
                          ),
                        ),
                      ),
                    ]))));
  }
}
