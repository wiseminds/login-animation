import 'package:common/common.dart';
import 'package:common/extensions/index.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/back.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget implements AppRoute {
  const ProfileScreen({Key? key}) : super(key: key);

  static String get routeName => 'profile-screen';

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
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.PADDING_SMALL),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimens.PADDING_SMALL),
                      Row(
                        children: [
                          const Back(),
                          Text(
                            'Edit Profile',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                      const Expanded(
                        child: EditProfile(),
                      )
                    ]))));
  }
}
