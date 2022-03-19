import 'package:common/common.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:customer/constants/svg_strings.dart';
import 'package:flutter/material.dart';

import 'account_screen.dart';

class SupportScreen extends StatelessWidget implements AppRoute {
  static String get routeName => 'support-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        // color: context.backgroundColor,
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.PADDING_EX_SMALL - 4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dimens.PADDING_SMALL.h,
                      Row(
                        children: [
                          const BackButton(),
                          Text(
                            'Support',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      16.0.h,
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.PADDING_EX_SMALL),
                          child: AccountTile(
                              title: 'Voice Call',
                              icon: SvgStrings.call,
                              onPressed: () {
                                // Get.toNamed(ProfileScreen.routeName);
                              })),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.PADDING_EX_SMALL),
                          child: AccountTile(
                              title: 'Chat With Us',
                              icon: SvgStrings.support,
                              onPressed: () {
                                // Get.toNamed(NotificationScreen.routeName);
                              })),
                    ]))));
  }
}
