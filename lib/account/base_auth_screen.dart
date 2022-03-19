// import 'package:common/extensions/index.dart';
// import 'package:common/constants/dimens.dart';
// import 'package:flutter/material.dart';
// import 'package:customer/constants/image_assets.dart';
// import 'package:flutter/widgets.dart';

// class BaseAuthScreen extends StatelessWidget {
//   final Widget child;
//   final Widget? backButton;
//   final bool showBackbutton;
//   final String title, subtitle;
//   const BaseAuthScreen(
//       {Key? key,
//       required this.child,
//       this.showBackbutton = false,
//       this.title = '',
//       this.subtitle = '', this.backButton})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // print(MediaQuery.of(context).size);
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Material(
//           color: Theme.of(context).backgroundColor,
//           child: Stack(
//             children: [
//               SizedBox(
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: Dimens.PADDING_SMALL),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(height: showBackbutton ? 50 : 40),
//                         SizedBox(
//                             height: 56,
//                             child: Image.asset(ImageAssets.LOGO,
//                                 package: 'common')),
//                         // Material(

//                         16.0.h,
//                         Text(title,
//                             style: context.headline3?.copyWith(
//                                 fontWeight: FontWeight.w900, fontSize: 20)),
//                         10.0.h,
//                         Text(subtitle, style: context.bodyText2),
//                         Expanded(child: child),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               if (showBackbutton)
//                   Positioned(
//                     top: 0, left: 10, child: SafeArea(child: backButton ?? BackButton()))
//             ],
//           )),
//     );
//   }
// }
