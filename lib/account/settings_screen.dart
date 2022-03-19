import 'package:common/common.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:customer/constants/svg_strings.dart';
import 'package:customer/views/account/preferences_screen.dart';
import 'package:common/widgets/back.dart';
import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatelessWidget implements AppRoute {
  static String get routeName => 'settings-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        // color: context.backgroundColor,
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.PADDING_EX_SMALL),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dimens.PADDING_SMALL.h,
                      Row(
                        children: [
                          const Back(),
                          Text(
                            'Settings',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      16.0.h,
                      AccountTile(
                          title: 'Change Password',
                          icon: SvgStrings.lock,
                          onPressed: () {
                            Get.toNamed(ChangePasswordScreen.routeName);
                          }),
                      AccountTile(
                          title: 'Preferences',
                          icon: SvgStrings.settings,
                          onPressed: () {
                            Get.toNamed(PreferencesScreen.routeName);
                          }),
                    ]))));
  }
}
