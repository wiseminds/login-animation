import 'package:customer/views/share_n_earn/share_and_earn.dart';
import 'package:customer/views/tab/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/modules/account/bloc/auth/auth_bloc.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/citi_dialog.dart';
import 'package:customer/constants/svg_strings.dart';
import 'package:customer/views/account/notifications_screen.dart';
import 'package:customer/views/account/support_screen.dart'; 
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'about_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';


class MenuScreen extends StatelessWidget implements AppRoute {
  const MenuScreen({Key? key}) : super(key: key);

  static String get routeName => 'menu-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;



  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.cardColor,
        child: SafeArea(
            child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.PADDING_EX_SMALL),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Menu',
                    style: context.headline4?.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                .0.s,
                Material(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: 8.0.toBorderRadius,
                        side: BorderSide(
                            color: Get.isDarkMode
                                ? const Color(0xFF3C3C3F)
                                : const Color(0xffE9E9EE))),
                    color: context.isDark
                        ? context.canvasColor
                        : const Color(0xffF9F9FB),
                    child: InkWell(
                      onTap: Navigator.of(context).pop,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.string(SvgStrings.close,
                            color: context.bodyText1!.color),
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: Dimens.PADDING_SMALL),
            Expanded(
              child: ListView(
                children: [
                  // SizedBox(height: 100),
                  AccountTile(
                      title: 'Profile',
                      icon: SvgStrings.profile,
                      onPressed: () {
                        Get.toNamed(ProfileScreen.routeName);
                      }),
                  AccountTile(
                      title: 'Notifications',
                      icon: SvgStrings.bell,
                      onPressed: () {
                        Get.toNamed(NotificationScreen.routeName);
                      }),
                  AccountTile(
                      title: 'My Orders',
                      icon: SvgStrings.basket,
                      onPressed: () {
                        context
                            .read<PersistentTabController>()
                            .jumpToTab(Tabs.order);
                        Navigator.pop(context);
                      }),
                  AccountTile(
                      title: 'Pending Reviews',
                      icon: SvgStrings.star,
                      onPressed: () {
                        // Get.toNamed(ChangePasswordScreen.routeName);
                      }),

                  AccountTile(
                      title: 'Share & Earn',
                      icon: SvgStrings.gift,
                      onPressed: () {
                        Get.toNamed(ShareNEarn.routeName);
                      }),
                  AccountTile(
                      title: 'Gift Cards',
                      icon: SvgStrings.giftCard,
                      onPressed: () {
                        // Get.toNamed(OrderScreen.routeName);
                      }),
                  AccountTile(
                      title: 'Loyalty Card',
                      icon: SvgStrings.smile,
                      onPressed: () {
                        // Get.toNamed(OrderScreen.routeName);
                      }),
                  AccountTile(
                      title: 'Settings',
                      icon: SvgStrings.settings,
                      onPressed: () {
                        Get.toNamed(SettingsScreen.routeName);
                      }),
                  AccountTile(
                      title: 'About',
                      icon: SvgStrings.about,
                      onPressed: () {
                        Get.toNamed(AboutScreen.routeName);
                      }),

                  AccountTile(
                      title: 'Support',
                      icon: SvgStrings.support,
                      onPressed: () {
                        Get.toNamed(SupportScreen.routeName);
                      }),

                  AccountTile(
                      title: 'Favorites',
                      icon: SvgStrings.like,
                      onPressed: () {
                        // Get.toNamed(AboutScreen.routeName);
                      }),

                  AccountTile(
                      title: 'Logout',
                      icon: SvgStrings.SIGN_OUT,
                      onPressed: () {
                        CitiDialog.info(Get.context!, 'Logout',
                            'Are you sure you want to log out of your account? ?',
                            button: (c) async {
                          Navigator.pop(c);
                          BlocProvider.of<AuthBloc>(context).add(LogOut());
                        },
                            buttonLabel: 'Logout',
                            buttonLabelAlt: 'Go back',
                            buttonAlt: Navigator.pop);
                      },
                      iconColor: const Color(0xffFF2E5B)),
                  50.0.h,
                ],
              ),
            ),
          ]),
        )));
  }
}

class AccountTile extends StatelessWidget {
  final String title, icon;
  final Function() onPressed;
  final Color? iconColor;
  const AccountTile(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.iconColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Get.isDarkMode ? const Color(0xFF27272B) : const Color(0xffF9F9FB);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: 8.0.toBorderRadius,
            side: BorderSide(
                color: Get.isDarkMode
                    ? const Color(0xFF3C3C3F)
                    : const Color(0xffE9E9EE))),
        clipBehavior: Clip.antiAlias,
        color: color,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Material(
                  color: iconColor ??
                      (context.isDark
                          ? context.primaryColor
                          : const Color(0xff171725)),
                  shape: const CircleBorder(),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(7),
                          child: SvgPicture.string(icon))),
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: context.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: iconColor,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: SvgPicture.string(SvgStrings.FORWARD_ICON,
                      color: Get.isDarkMode
                          ? context.primaryColor
                          : Colors.black54),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
