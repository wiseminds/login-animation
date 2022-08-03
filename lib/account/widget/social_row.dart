import 'package:common/common.dart';
import 'package:customer/services/social_auth/apple_login.dart';
import 'package:customer/services/social_auth/facebook_login.dart';
import 'package:customer/services/social_auth/google_signin.dart';
import 'package:customer/services/social_auth/social_login.dart';
import 'package:customer/services/social_auth/widget/social_button.dart';
import 'package:customer/views/account/cubit/customer_login_cubit.dart';
import 'package:flutter/material.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    login(SocialOptions option, SocialAuthResult result) {
      context.read<CustomerLoginCubit>().social(option, result);
    }

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.white.withOpacity(.6),
            width: 100,
            height: 1,
          ),
          20.0.w,
          Text('Or login with',
              style: context.caption?.copyWith(
                color: Colors.white.withOpacity(.5),
              )),
          20.0.w,
          Container(
            color: Colors.white.withOpacity(.6),
            width: 100,
            height: 1,
          ),
        ],
      ),
      16.0.h,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialButton(
              option: SocialOptions.google,
              socialLogin: GoogleSingin(),
              onPressed: (result) {
                login(SocialOptions.google, result);
              }),
          SocialButton(
              option: SocialOptions.facebook,
              socialLogin: FacebookSignin(),
              onPressed: (result) {
                login(SocialOptions.facebook, result);
              }),
          SocialButton(
              option: SocialOptions.apple,
              socialLogin: AppleLogin(),
              onPressed: (result) {
                login(SocialOptions.apple, result);
              })
        ],
      )
    ]);
  }
}
