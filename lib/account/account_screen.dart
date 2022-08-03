import 'package:common/common.dart';
import 'package:common/extensions/index.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/modules/account/bloc/auth/auth_bloc.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/cached_image.dart';
import 'package:common/widgets/citi_dialog.dart';
import 'package:customer/constants/svg_strings.dart';
import 'package:customer/views/account/notifications_screen.dart';
import 'package:customer/views/account/support_screen.dart';
import 'package:customer/views/address/address_screen.dart';
import 'package:customer/views/order/orders_screen.dart';
import 'package:customer/views/share_n_earn/share_and_earn.dart';
import 'package:customer/views/tab/tab_view.dart';
import 'package:customer/widgets/gradient_decoration.dart';
import 'package:customer/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';

class AccountScreen extends StatelessWidget implements AppRoute {
  const AccountScreen({Key? key}) : super(key: key);

  static String get routeName => 'account-screen';

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
        child: Container(
          decoration: GradientDecoration(),
          child: SafeArea(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.PADDING_EX_SMALL),
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text('My Account',
                          style: context.headline4?.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      .0.s,
                      const MenuButton()
                    ],
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Center(
                        child: Stack(
                          children: [
                            Material(
                                type: MaterialType.transparency,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: context.isDark
                                            ? Color(0xFF3D3C3C)
                                            : const Color(0xff171725)
                                                .withOpacity(.08))),
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                )),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: SvgPicture.string(SvgStrings.curve)),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                  shape: const CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedImage(
                                    url: state.user?.profile?.profilePicture ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ7zG-LebllCiEPRZSdrLqdHlPnzD60B0Vow&usqp=CAU',
                                    height: 100,
                                    width: 100,
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  16.0.h,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      var usr = state.user?.profile;
                      return Center(
                          child: Text(
                        '${usr?.firstName ?? ''} ${usr?.lastName ?? ''}',
                        style: context.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ));
                    },
                  ),
                  40.0.h,

                  // SizedBox(height: 100),
                  AccountTile(
                      title: 'Edit Profile',
                      icon: SvgStrings.profile,
                      onPressed: () {
                        Get.toNamed(ProfileScreen.routeName);
                      }),

                  // AccountTile(
                  //     title: 'My Orders',
                  //     icon: SvgStrings.basket,
                  //     onPressed: () {
                  //       context
                  //           .read<PersistentTabController>()
                  //           .jumpToTab(Tabs.order);
                  //       // Get.toNamed(OrderScreen.routeName);
                  //     }),
                  AccountTile(
                      title: 'Saved Addresses',
                      icon: SvgStrings.star,
                      onPressed: () {
                        Get.toNamed(AddressScreen.routeName);
                      }),
                  AccountTile(
                      title: 'Share & Earn',
                      icon: SvgStrings.gift,
                      onPressed: () {
                        Get.toNamed(ShareNEarn.routeName);
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
                ]),
          )),
        ));
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
    var color = Get.isDarkMode ? Color(0xFF27272B) : Color(0xffF9F9FB);
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
                SizedBox(width: 20),
                Text(
                  title,
                  style: context.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: iconColor,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
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
