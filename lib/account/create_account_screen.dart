import 'package:common/common.dart';
import 'package:common/constants/svg_strings.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/medium_button.dart';
import 'package:customer/constants/image_assets.dart';
import 'package:customer/services/social_auth/facebook_login.dart';
import 'package:customer/services/social_auth/google_signin.dart';
import 'package:customer/services/social_auth/twitter_signin.dart';
import 'package:customer/views/account/login_screen.dart';
import 'package:customer/views/account/register_screen.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget implements AppRoute {
  const CreateAccountScreen({Key? key}) : super(key: key);

  static String get routeName => 'create-account-screen';

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
            Image.asset(ImageAssets.welcome, fit: BoxFit.fill),
            Positioned(
                top: 0,
                height: 200,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black,
                        Colors.black87,
                        Colors.black12.withOpacity(.01),
                      ])),
                  height: 10,
                )),
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.PADDING_NORMAL),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          40.0.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 40,
                                  child: SvgPicture.string(
                                      SvgStrings.CITI_SQUARE)),
                              4.0.h,
                              const Text('CITISQUARE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      letterSpacing: 3))
                            ],
                          ),
                          24.0.h,
                          _SlideAnimation(
                              delay: 700,
                              key: const ValueKey('Slide-7'),
                              customTweenOffset: Tween(
                                  begin: const Offset(0, -10),
                                  end: const Offset(0, 0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  'Food, Groceries, Supermarkets, Fashion, Pharmacies, and much more.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                ),
                              )),
                          .0.s,
                          _SlideAnimation(
                              delay: 100,
                              customTweenOffset: Tween(
                                  begin: const Offset(10, 0),
                                  end: const Offset(0, 0)),
                              key: const ValueKey('Slide-1'),
                              child: MediumButton(
                                label: 'Continue with Phone or Email',
                                onPressed: () =>
                                    Get.toNamed(RegisterScreen.routeName),
                                color: Colors.white,
                                textColor: Colors.black,
                              )),
                          14.0.h,
                          _SlideAnimation(
                              delay: 200,
                              customTweenOffset: Tween(
                                  begin: const Offset(10, 0),
                                  end: const Offset(0, 0)),
                              key: const ValueKey('Slide-2'),
                              child: MediumButton(
                                label: 'Continue with Facebook',
                                onPressed: () async {
                                  var result =
                                      await FacebookSignin().handleSignIn();
                                  FacebookSignin().handleSignOut();
                                  // print(result);
                                  if (result.email != null) {
                                    Get.to(() => RegisterScreen(
                                          socialAuthResult: result,
                                        ));
                                  }
                                },
                                color: const Color(0xff3A4BE5),
                                textColor: Colors.white,
                              )),
                          14.0.h,
                          _SlideAnimation(
                              delay: 200,
                              customTweenOffset: Tween(
                                  begin: const Offset(10, 0),
                                  end: const Offset(0, 0)),
                              key: const ValueKey('Slide-3'),
                              child: MediumButton(
                                label: 'Continue with Google',
                                onPressed: () async {
                                  var result =
                                      await GoogleSingin().handleSignIn();
                                  // print(result);
                                  GoogleSingin().handleSignOut();
                                  if (result.email != null) {
                                    Get.to(() => RegisterScreen(
                                          socialAuthResult: result,
                                        ));
                                  }
                                },
                                // Get.toNamed(RegisterScreen.routeName),
                                color: const Color(0xffDF361E),
                                textColor: Colors.white,
                              )),
                          14.0.h,
                          _SlideAnimation(
                              delay: 200,
                              customTweenOffset: Tween(
                                  begin: const Offset(10, 0),
                                  end: const Offset(0, 0)),
                              key: const ValueKey('Slide-tw'),
                              child: MediumButton(
                                label: 'Continue with Twitter',
                                onPressed: () async {
                                  var result =
                                      await TwitterSignInn().handleSignIn();
                                  // print(result.body);
                                  TwitterSignInn().handleSignOut();
                                  if (result.email != null) {
                                    Get.to(() => RegisterScreen(
                                          socialAuthResult: result,
                                        ));
                                  }
                                },
                                color: const Color(0xff00acee),
                                textColor: Colors.white,
                              )),
                          14.0.h,
                          // _SlideAnimation(
                          //     delay: 200,
                          //     customTweenOffset: Tween(
                          //         begin: const Offset(10, 0),
                          //         end: const Offset(0, 0)),
                          //     key: const ValueKey('Slide-4'),
                          //     child: MediumButton(
                          //       label: 'Continue with Apple',
                          //       onPressed: () =>
                          //           Get.toNamed(LoginScreen.routeName),
                          //       color: Colors.black,
                          //       textColor: Colors.white,
                          //     )),
                          // 14.0.h,
                          // _SlideAnimation(
                          //     delay: 200,
                          //     customTweenOffset: Tween(
                          //         begin: const Offset(10, 0),
                          //         end: const Offset(0, 0)),
                          //     key: const ValueKey('Slide-5'),
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
        animDuration: 700.toDurationInMilliseconds,
        curve: Curves.decelerate,
        extend: 10,
        cutomTweenOffset: widget.customTweenOffset ??
            Tween(begin: const Offset(10, 0), end: const Offset(0, 0)),
        withFade: true,
        animStatus: (AnimStatus status) {
          print(status);
        },
        child: widget.child);
  }
}
