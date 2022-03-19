import 'package:auth/cubit/login_cubit.dart';
import 'package:auth/cubit/login_form_cubit.dart';
import 'package:auth/widgets/base_auth_screen.dart';
import 'package:auth/widgets/send_reset_button.dart';
import 'package:common/extensions/index.dart';
import 'package:common/common.dart';
import 'package:common/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:auth/widgets/email_field.dart';

import 'cubit/customer_login_repository.dart';

class ForgotPasswordScreen extends StatelessWidget implements AppRoute {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static String get routeName => 'Forgot-password';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;

  @override
  Widget build(BuildContext context) {
    return const BaseAuthScreen(
        title: 'Reset Password',
        subtitle: 'Enter email address to reset password.',
        showBackbutton: true,
        child: _ForgotPasswordForm());
  }
}

/// ForgotPassword form
class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  late LoginFormCubit _formCubit;
  final FocusNode _emailNode = FocusNode(debugLabel: 'email');
  final FocusNode _passNode = FocusNode(debugLabel: 'password');
  final _formKey = GlobalKey<FormState>();
  late LoginCubit _cubit;

  @override
  void initState() {
    _formCubit = LoginFormCubit();
    _cubit = LoginCubit(CustomerLoginRepository());
    super.initState();
  }

  @override
  void dispose() {
    _formCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: BlocBuilder<LoginCubit, LoginState>(
        bloc: _cubit,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                // SizedBox(height: 50),
                50.0.h,
                EmailField(
                  node: _emailNode,
                  nextNode: _passNode,
                  cubit: _cubit,
                  formcubit: _formCubit,
                ),
                10.0.h,
                .0.s,
                SendResetButton(
                  cubit: _cubit,
                  formCubit: _formCubit,
                  color: context.primaryColor,
                  textColor: Colors.white,
                ),
                40.0.h,
              ],
            ),
          );
        },
      ),
    );
  }
}
