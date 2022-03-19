import 'package:common/common.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/app_checkbox.dart';
import 'package:customer/customer_theme.dart';
import 'package:customer/services/social_auth/apple_login.dart';
import 'package:customer/services/social_auth/facebook_login.dart';
import 'package:customer/services/social_auth/google_signin.dart';
import 'package:customer/services/social_auth/widget/social_button.dart';
import 'package:customer/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:auth/cubit/login_cubit.dart';
import 'package:auth/cubit/login_form_cubit.dart';
import 'package:auth/widgets/email_field.dart';
import 'package:auth/widgets/forgot_password_button.dart';
import 'package:auth/widgets/login_button.dart';
import 'package:auth/widgets/password_field.dart';

import 'cubit/customer_login_cubit.dart';
import 'forgot_password_screen.dart';
import 'cubit/customer_login_repository.dart';
import 'register_screen.dart';
import 'widget/auth_grid_header.dart';
import 'widget/social_row.dart';

// import '../base_auth_screen.dart';
enum LoginOption { login, signup }

class LoginOptionCubit extends Cubit<LoginOption> {
  LoginOptionCubit(LoginOption option)
      : controller = PageController(initialPage: option.index + 1),
        super(option) {
    Future.delayed(const Duration(microseconds: 500), () => value = option);
  }

  final PageController controller;

  set value(LoginOption option) {
    controller.animateToPage(option.index,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 500));
    emit(option);
  }
}

class Delay extends StatefulWidget {
  final Duration delay;
  final Widget child;
  const Delay({Key? key, required this.child, this.delay = Duration.zero})
      : super(key: key);

  @override
  State<Delay> createState() => _DelayState();
}

class _DelayState extends State<Delay> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (show) return widget.child;
    return Container();
  }
}

class LoginScreen extends StatelessWidget implements AppRoute {
  const LoginScreen({Key? key, this.option = LoginOption.login})
      : super(key: key);
  final LoginOption option;

  static String get routeName => 'login';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;

  @override
  Widget build(BuildContext context) {
    return
        // BaseAuthScreen(
        // showBackbutton: Navigator.canPop(context),
        // title: 'Welcome!',
        // subtitle: 'Login to continue.',
        Theme(
      data: CustomerTheme().dark,
      child: Material(
        child: Stack(fit: StackFit.expand, children: [
          // Image.asset(ImageAssets.welcome, fit: BoxFit.fill),
          const GradientBackground(),
          const Positioned(
              top: -120,
              left: -20,
              right: -20,
              child: AuthGridHeader(
                alternate: true,
              )),
          BlocProvider(
              create: (context) => LoginOptionCubit(option),
              child: BlocListener<LoginOptionCubit, LoginOption>(
                  listener: (context, state) {},
                  child: Builder(
                    builder: (context) {
                      final controller =
                          context.read<LoginOptionCubit>().controller;
                      return Column(children: [
                        340.0.h,
                        BlocBuilder<LoginOptionCubit, LoginOption>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                // fit: StackFit.expand,
                                children: [
                                  Delay(
                                    delay: const Duration(milliseconds: 500),
                                    child: Spring.fadeIn(
                                      child: AnimatedBuilder(
                                        animation: controller,
                                        builder: (c, w) => Transform.translate(
                                          offset: Offset(
                                              state == LoginOption.login
                                                  ? 20 *
                                                      (1 -
                                                          (controller.page ??
                                                              1))
                                                  : -20 *
                                                      (controller.page ?? 1),
                                              0),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            LoginOptionCubit>()
                                                        .value = LoginOption.login;
                                                  },
                                                  child: Text('Login',
                                                      style: context.headline5?.copyWith(
                                                          color: Colors.white
                                                              .withOpacity(state ==
                                                                      LoginOption
                                                                          .login
                                                                  ? 1
                                                                  : .5),
                                                          fontSize: 44,
                                                          fontWeight: FontWeight
                                                              .w900))),
                                              .0.s,
                                              InkWell(
                                                  onTap: () {
                                                    context
                                                            .read<
                                                                LoginOptionCubit>()
                                                            .value =
                                                        LoginOption.signup;
                                                  },
                                                  child: Text(
                                                    'Sign Up',
                                                    style: context.headline5?.copyWith(
                                                        color: Colors.white
                                                            .withOpacity(state ==
                                                                    LoginOption
                                                                        .login
                                                                ? .5
                                                                : 1),
                                                        fontSize: 44,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //     left: 20,
                                  //     top: 0,
                                  //     child: InkWell(
                                  //         onTap: () {
                                  //           context
                                  //               .read<LoginOptionCubit>()
                                  //               .value = LoginOption.login;
                                  //         },
                                  //         child: Text('Login',
                                  //             style: context.headline5
                                  //                 ?.copyWith(
                                  //                     color: Colors.white
                                  //                         .withOpacity(state ==
                                  //                                 LoginOption
                                  //                                     .login
                                  //                             ? 1
                                  //                             : .5),
                                  //                     fontSize: 44,
                                  //                     fontWeight:
                                  //                         FontWeight.w900)))),
                                  // Positioned(
                                  //     right: -50,
                                  //     top: 0,
                                  // child: InkWell(
                                  //     onTap: () {
                                  //       context
                                  //           .read<LoginOptionCubit>()
                                  //           .value = LoginOption.signup;
                                  //     },
                                  //     child: Text(
                                  //       'Sign Up',
                                  //       style: context.headline5?.copyWith(
                                  //           color: Colors.white.withOpacity(
                                  //               state == LoginOption.login
                                  //                   ? .5
                                  //                   : 1),
                                  //           fontSize: 44,
                                  //           fontWeight: FontWeight.w900),
                                  //     ))),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.0.height),
                        Expanded(
                            child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller:
                                    context.read<LoginOptionCubit>().controller,
                                children: const [_LoginForm(), RegisterForm()]))
                      ]);
                    },
                  )))
        ]),
      ),
    );
  }
}

/// login form
class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  late LoginFormCubit _formCubit;
  final FocusNode _emailNode = FocusNode(debugLabel: 'email');
  final FocusNode _passNode = FocusNode(debugLabel: 'password');
  final _formKey = GlobalKey<FormState>();
  late CustomerLoginCubit _cubit;

  @override
  void initState() {
    _formCubit = LoginFormCubit();
    _cubit = CustomerLoginCubit();
    super.initState();
  }

  var acceptedTerms = false.obs;

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
                return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: ListView(
                        children: [
                          EmailField(
                            filled: false,
                            fillColor: Colors.transparent,
                            node: _emailNode,
                            nextNode: _passNode,
                            cubit: _cubit,
                            formcubit: _formCubit,
                          ),
                          10.0.h,
                          PasswordField(
                            filled: false,
                            node: _passNode,
                            formcubit: _formCubit,
                            cubit: _cubit,
                            onDone: () => _formCubit.state.isLoginValid
                                ? _cubit.login(_formCubit.state.email ?? '',
                                    _formCubit.state.password ?? '')
                                : null,
                          ),
                          const SizedBox(height: 13),
                          Row(
                            children: [
                              Obx(
                                () => AppCheckbox(
                                  checked: acceptedTerms.value,
                                  onChanged: (value) =>
                                      acceptedTerms.value = value,
                                ),
                              ),
                              8.0.w,
                              Text(
                                'Remember me ',
                                style: context.caption!,
                              ),
                              .0.s,
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: ForgotPasswordButton(
                                      routeName: ForgotPasswordScreen.routeName,
                                      style: context.caption?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      color: context.primaryColor)),
                            ],
                          ),
                          // .0.s,
                          30.0.h,
                          LoginButton(
                            radius: 2.0,
                            cubit: _cubit,
                            formCubit: _formCubit,
                            textColor: context.primaryColor,
                            color: Colors.white,
                          ),

                          47.0.h,
                          const SocialRow(),
                          100.0.h
                        ],
                      ),
                    ));
              })),
    );
  }
}
