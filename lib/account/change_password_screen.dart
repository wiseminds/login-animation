import 'package:auth/cubit/login_cubit.dart';
import 'package:auth/cubit/login_form_cubit.dart';
import 'package:auth/widgets/confirm_password_field.dart';
import 'package:auth/widgets/old_password_field.dart';
import 'package:auth/widgets/password_field.dart';
import 'package:common/common.dart';
import 'package:common/constants/dimens.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/citi_dialog.dart';
import 'package:common/widgets/medium_button.dart';
import 'package:customer/views/account/cubit/customer_login_repository.dart';
import 'package:common/widgets/back.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget implements AppRoute {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  static String get routeName => 'change-password-screen';

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
                    horizontal: Dimens.PADDING_EX_SMALL),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dimens.PADDING_SMALL.h,
                      Row(
                        children: [
                          const Back(),
                          Text(
                            'Change Password',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                      const Expanded(child: _PasswordForm())
                    ]))));
  }
}

class _PasswordForm extends StatefulWidget {
  const _PasswordForm({Key? key}) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<_PasswordForm> {
  late LoginFormCubit _formCubit;
  final FocusNode _pass2Node = FocusNode(debugLabel: 'password2');
  final FocusNode _passNode = FocusNode(debugLabel: 'password');
  final FocusNode _cPassNode = FocusNode(debugLabel: 'password');
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
      child: BlocBuilder<LoginFormCubit, LoginFormState>(
        bloc: _formCubit,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                50.0.h,
                OldPasswordField(
                  filled: true,
                  fillColor: context.isDark ? Colors.black : Colors.white,
                  node: _pass2Node,
                  formcubit: _formCubit,
                  cubit: _cubit,
                  nextNode: _passNode,
                ),
                PasswordField(
                  filled: true,
                  fillColor: context.isDark ? Colors.black : Colors.white,
                  node: _passNode,
                  formcubit: _formCubit,
                  cubit: _cubit,
                  label: 'New password',
                ),
                ConfirmPasswordField(
                  filled: true,
                  fillColor: context.isDark ? Colors.black : Colors.white,
                  cubit: _cubit,
                  formcubit: _formCubit,
                  node: _cPassNode,
                  onDone: () {},
                ),
                .0.s,
                20.0.h,
                BlocConsumer<LoginCubit, LoginState>(
                    bloc: _cubit,
                    listener: (context, state) {
                      if (state is ResetSuccessLoginState) {
                        Navigator.pop(context);
                        CitiDialog.info(Get.context!, 'Success',
                            'Password changed successfully',
                            buttonLabel: 'Close', button: Navigator.pop);
                      } else if (state is FailureLoginState) {
                        CitiDialog.showError(context, state.error, overrides: [
                          'new_password',
                          "old_password",
                        ]);
                      }
                    },
                    builder: (c, loginState) => MediumButton(
                          color: context.isDark
                              ? Colors.white30
                              : context.primaryColor,
                          textColor:
                              context.isDark ? Colors.black54 : Colors.white,
                          label: 'Submit',
                          onPressed: state.isChangePasswordValid
                              ? () {
                                  _cubit.changePassword(state.oldPassword ?? '',
                                      state.password ?? '');
                                }
                              : null,
                          varyOpacity: true,
                          isLoading: loginState is LoadingLoginState,
                        )),
                20.0.h,
              ],
            ),
          );
        },
      ),
    );
  }
}
