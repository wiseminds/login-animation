import 'dart:math';

import 'package:auth/widgets/base_auth_screen.dart';
import 'package:auth/widgets/confirm_password_field.dart';
import 'package:auth/widgets/name_field.dart';
import 'package:auth/widgets/register_button.dart';
import 'package:common/common.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/citi_text_button.dart';
import 'package:common/widgets/terms_button.dart';
import 'package:customer/services/social_auth/social_login.dart';
import 'package:flutter/material.dart';
import 'package:auth/cubit/login_cubit.dart';
import 'package:auth/cubit/login_form_cubit.dart';
import 'package:auth/widgets/email_field.dart';
import 'package:auth/widgets/password_field.dart';

import 'cubit/customer_login_cubit.dart';
import 'cubit/customer_login_repository.dart';

// import 'base_auth_screen.dart';
import 'login_screen.dart';
import 'widget/social_row.dart';

class RegisterScreen extends StatelessWidget implements AppRoute {
  const RegisterScreen({Key? key, this.socialAuthResult}) : super(key: key);

  static String get routeName => 'register';

  @override
  Widget get page => this;

  @override
  String get route => routeName;
  final SocialAuthResult? socialAuthResult;

  @override
  Transition get transition => Transition.cupertino;

  @override
  Widget build(BuildContext context) {
    return BaseAuthScreen(
        showBackbutton: Navigator.canPop(context),
        title: 'Create an account',
        subtitle: '',
        child: RegisterForm(socialAuthResult: socialAuthResult));
  }
}

/// login form
class RegisterForm extends StatefulWidget {
  final SocialAuthResult? socialAuthResult;
  const RegisterForm({Key? key, this.socialAuthResult}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  late LoginFormCubit _formCubit;
  final FocusNode _emailNode = FocusNode(debugLabel: 'email');
  final FocusNode _passNode = FocusNode(debugLabel: 'password');
  final FocusNode _pass2Node = FocusNode(debugLabel: 'password2');
  final FocusNode _fNameNode = FocusNode(debugLabel: 'f-name');
  final FocusNode _lNameNode = FocusNode(debugLabel: 'l-name');
  final _formKey = GlobalKey<FormState>();
  late CustomerLoginCubit _cubit;

  var acceptedTerms = false.obs;

  @override
  void initState() {
    _formCubit = LoginFormCubit();
    _cubit = CustomerLoginCubit();
    if (widget.socialAuthResult != null) {
      _formCubit
        ..emailChanged(widget.socialAuthResult?.email ?? '')
        ..fNameChanged(widget.socialAuthResult?.firstName ?? '')
        // ..fNameChanged(widget.socialAuthResult?.p ?? '')
        ..lNameChanged(widget.socialAuthResult?.lastName ?? '');
    }
    super.initState();
  }

  @override
  void dispose() {
    _formCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: AutofillGroup(
        child: BlocBuilder<CustomerLoginCubit, LoginState>(
          bloc: _cubit,
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      // 50.0.h,
                      NameField(
                        firstNamenode: _fNameNode,
                        lastNamenode: _lNameNode,
                        nextNode: _emailNode,
                        cubit: _cubit,
                        formcubit: _formCubit,
                      ),
                      10.0.h,
                      EmailField(
                        node: _emailNode,
                        nextNode: _passNode,
                        cubit: _cubit,
                        formcubit: _formCubit,
                      ),
                      10.0.h,
                      PasswordField(
                        node: _passNode,
                        nextNode: _pass2Node,
                        formcubit: _formCubit,
                        cubit: _cubit,
                      ),
                      10.0.h,
                      ConfirmPasswordField(
                        node: _pass2Node,
                        formcubit: _formCubit,
                        cubit: _cubit,
                      ),

                      Obx(() => TermsButton(
                            checked: acceptedTerms.value,
                            onChanged: (value) => acceptedTerms.value = value,
                          )),
                      30.0.h,
                      // Spacer(),
                      // SizedBox(height: _calculateHeight()),
                      Obx(() => RegisterButton(
                            radius: 2.0,
                            acceptedTerms: acceptedTerms.value,
                            cubit: _cubit,
                            formCubit: _formCubit,
                            textColor: context.primaryColor,
                            color: Colors.white,
                          )),
                      // 20.0.h,

                      40.0.h,
                      const SocialRow(),
                      100.0.h,
                    ])));
          },
        ),
      ),
    );
  }

  double _calculateHeight() {
    var height = MediaQuery.of(context).size.height;
    // print(height - 500);
    var h = 10.0;
    if (height > 670.0) {
      h += height / 7;
    }
    return min(180, h);
  }
}
