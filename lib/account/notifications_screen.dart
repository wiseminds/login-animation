import 'package:common/common.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:customer/constants/svg_strings.dart';
import 'package:common/widgets/back.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget implements AppRoute {
  static String get routeName => 'notifications-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;
  const NotificationScreen({Key? key}) : super(key: key);

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
                            'Notifications',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      .0.s,
                      Material(
                        borderRadius: 8.0.toBorderRadius,
                        color: context.isDark ? Colors.black : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SvgPicture.string(SvgStrings.bell,
                              color: context.isDark
                                  ? Colors.white
                                  : context.primaryColor),
                        ),
                      ),
                      16.0.h,
                      Text(
                        'There are no notifications here at the moment.',
                        textAlign: TextAlign.center,
                        style: context.bodyText1?.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      .0.s,
                    ]))));
  }
}
