import 'package:common/common.dart';
import 'package:customer/views/account/menu_screen.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: 8.0.toBorderRadius,
        child: InkWell(
          child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
              child: Icon(Icons.menu)),
          onTap: () {
            // Navigator.of(context).pushNamed(MenuScreen.routeName);
            Get.to(() => const MenuScreen());
          },
        ));
  }
}
