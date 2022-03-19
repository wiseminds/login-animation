import 'package:common/common.dart';
import 'package:common/constants/svg_strings.dart';
import 'package:common/extensions/index.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/medium_button.dart';
import 'package:customer/constants/image_assets.dart';
import 'package:customer/views/account/login_screen.dart';
import 'package:customer/views/account/register_screen.dart';
import 'package:customer/widgets/gradient_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_account_screen.dart';
import 'widget/auth_grid_header.dart';

class WelcomeScreen extends StatelessWidget implements AppRoute {
  const WelcomeScreen({Key? key}) : super(key: key);

  static String get routeName => 'welcome-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.backgroundColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image.asset(ImageAssets.welcome, fit: BoxFit.fill),
            const GradientBackground(),
            const Positioned(
                // height: 500,
                top: -60,
                left: -20,
                right: -20,
                child: AuthGridHeader()),
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.PADDING_NORMAL),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 40.0.h,

                          // 24.0.h,
                          //  Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 40.0),
                          //         child: Text(
                          //           'Food, Groceries, Supermarkets, Fashion, Pharmacies, and much more.',
                          //           textAlign: TextAlign.center,
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText1
                          //               ?.copyWith(
                          //                   fontWeight: FontWeight.w400,
                          //                   color: Colors.white),
                          //         ),
                          //       )),
                          .0.s,
                          _SlideAnimation(
                              // delay: 700,
                              key: const ValueKey('Slide-4'),
                              delay: 1000,
                              customTweenOffset: Tween(
                                  begin: const Offset(0, -10),
                                  end: const Offset(0, 0)),
                              child: Text(
                                'Welcome to Citisquare',
                                style: context.headline5?.copyWith(
                                    color: Colors.white,
                                    fontSize: 44,
                                    fontWeight: FontWeight.w900),
                              )),
                          22.0.h,
                          _SlideAnimation(
                              key: const ValueKey('Slide-7'),
                              slideType: SlideType.slide_in_top,
                              delay: 1000,
                              customTweenOffset: Tween(
                                  begin: const Offset(-100, 0),
                                  end: const Offset(0, 0)),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur \nadipiscing elit d do eiusmod tempor.',
                                style: context.bodyText2?.copyWith(
                                  color: Colors.white,
                                ),
                              )),
                          100.0.h,
                          Row(
                            children: [
                              Expanded(
                                child: _SlideAnimation(
                                    key: const ValueKey('Slide-1'),
                                    slideType: SlideType.slide_in_top,
                                    delay: 1000,
                                    customTweenOffset: Tween(
                                        begin: const Offset(-100, 0),
                                        end: const Offset(0, 0)),
                                    child: MediumButtonOutlined(
                                      radius: 2.0,
                                      label: 'Login',
                                      borderThickness: 1,
                                      onPressed: () =>
                                          Get.toNamed(LoginScreen.routeName),
                                      color: Colors.white,
                                      style: context.caption
                                          ?.copyWith(color: Colors.white),
                                      textColor: Colors.white,
                                    )),
                              ),
                              15.0.w,
                              Expanded(
                                child: _SlideAnimation(
                                    delay: 700,
                                    customTweenOffset: Tween(
                                        begin: const Offset(100, 0),
                                        end: const Offset(0, 0)),
                                    key: const ValueKey('Slide-2'),
                                    child: MediumButton(
                                      radius: 2.0,
                                      style: context.caption?.copyWith(
                                          color: context.primaryColor),
                                      label: 'Create Account',
                                      onPressed: () => Get.to(() =>
                                          const LoginScreen(
                                              option: LoginOption.signup)),
                                      color: Colors.white,
                                      textColor: Colors.black,
                                    )),
                              ),
                              // 14.0.h
                            ],
                          ),
                          14.0.h,

                          // _SlideAnimation(
                          //     delay: 500,
                          //     key: const ValueKey('Slide-3'),
                          //     child: MediumButton(
                          //       label: 'Continue as a Guest',
                          //       onPressed: () =>
                          //           Get.toNamed(LoginScreen.routeName),
                          //       color: const Color(0xffFFD850),
                          //       textColor: Colors.black,
                          //     )),
                          14.0.h,
                        ]))),
          ],
        ));
  }
}

class _SlideAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final SlideType slideType;
  final Tween<Offset>? customTweenOffset;
  const _SlideAnimation(
      {Key? key,
      required this.child,
      this.delay = 100,
      this.slideType = SlideType.slide_in_bottom,
      this.customTweenOffset})
      : super(key: key);

  @override
  __SlideAnimationState createState() => __SlideAnimationState();
}

class __SlideAnimationState extends State<_SlideAnimation> {
  final SpringController springController = SpringController();
  @override
  Widget build(BuildContext context) {
    return Spring.slide(
        springController: springController,
        slideType: widget.slideType,
        delay: widget.delay.toDurationInMilliseconds,
        animDuration: 600.toDurationInMilliseconds,
        curve: Curves.decelerate,
        extend: 10,
        cutomTweenOffset: widget.customTweenOffset ??
            Tween(begin: const Offset(0, 10), end: const Offset(0, 0)),
        withFade: true,
        animStatus: (AnimStatus status) {
          print(status);
        },
        child: widget.child);
  }
}
