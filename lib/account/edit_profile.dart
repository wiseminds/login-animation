import 'dart:math';

import 'package:auth/cubit/login_cubit.dart';
import 'package:auth/cubit/login_form_cubit.dart';
import 'package:auth/widgets/confirm_password_field.dart';
import 'package:auth/widgets/email_field.dart';
import 'package:auth/widgets/name_field.dart';
import 'package:common/common.dart';
import 'package:common/data/remote/file_field.dart';
import 'package:common/models/profile.dart';
import 'package:common/modules/account/bloc/auth/auth_bloc.dart';
import 'package:common/router/app_route.dart';
import 'package:common/widgets/citi_dialog.dart';
import 'package:common/widgets/edit_text_field.dart';
import 'package:common/widgets/medium_button.dart';
import 'package:customer/widgets/image_picker.dart';
import 'package:flutter/material.dart';

import 'cubit/customer_login_repository.dart';
import 'cubit/profile_cubit.dart';

class EditProfile extends StatelessWidget implements AppRoute {
  const EditProfile({Key? key}) : super(key: key);

  static String get routeName => 'edit-screen';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  @override
  Transition get transition => Transition.cupertino;

  @override
  Widget build(BuildContext context) {
    return const _EditProfileForm();
  }
}

/// login form
class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_EditProfileForm> {
  late LoginFormCubit _formCubit;
  final FocusNode _emailNode = FocusNode(debugLabel: 'email');
  final FocusNode _fNameNode = FocusNode(debugLabel: 'f-name');
  final FocusNode _lNameNode = FocusNode(debugLabel: 'l-name');
  final FocusNode _addressNode = FocusNode(debugLabel: 'l-name');
  final _formKey = GlobalKey<FormState>();
  late ProfileCubit _cubit;

  @override
  void initState() {
    var user = GetIt.I<AuthBloc>().state.user;
    _formCubit = LoginFormCubit();
    _cubit = ProfileCubit();
    _formCubit
      ..fNameChanged(user?.profile?.firstName ?? '')
      ..lNameChanged(user?.profile?.lastName ?? '')
      ..phoneChanged(user?.profile?.phoneNumber ?? '')
      // ..addressChanged(user?.profile?.address ?? '')
      ..emailChanged(user?.email ?? '')
      ..selfieChanged(user?.profile?.profilePicture ??
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ7zG-LebllCiEPRZSdrLqdHlPnzD60B0Vow&usqp=CAU');
    super.initState();
    // print(user?.profile?.profilePicture);
  }

  @override
  void dispose() {
    _formCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthBloc>().state;
    return AutofillGroup(
      child: BlocBuilder<ProfileCubit, LoginState>(
        bloc: _cubit,
        builder: (context, loginState) {
          return AutofillGroup(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  50.0.h,
                  Text(
                    'Profile Picture',
                    style:
                        context.caption?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  8.0.h,
                  BlocBuilder<LoginFormCubit, LoginFormState>(
                    bloc: _formCubit,
                    builder: (context, state) {
                      return CustomerImagePicker(
                        path: state.selfie,
                        onChanged: (path) {
                          // _formCubit.selfieChanged(path);
                          // _cubit.updateProfileAlt(
                          //     {'profile_picture': FileFormField(path: path)},
                          //     true);
                        },
                      );
                    },
                  ),
                  26.0.h,
                  NameField(
                    firstNamenode: _fNameNode,
                    lastNamenode: _lNameNode,
                    // nextNode: _emailNode,
                    cubit: _cubit,
                    formcubit: _formCubit,
                  ),
                  10.0.h,
                  EmailField(
                    enabled: false,
                    node: _emailNode,
                    cubit: _cubit,
                    formcubit: _formCubit,
                  ),
                  10.0.h,
                  BlocBuilder<LoginFormCubit, LoginFormState>(
                      bloc: _formCubit,
                      builder: (context, state) => EditTextField(
                          textInputAction: TextInputAction.next,
                          focusNode: _addressNode,
                          label: 'Phone number',
                          text: state.phone,
                          enabled: false,
                          errorText: (loginState is FailureLoginState)
                              ? loginState.getFromErrors(
                                  'phone_number', state.email ?? '')
                              : null,
                          autofillHints: [AutofillHints.postalAddress],
                          onChanged: _formCubit.addressChanged,
                          // validator: state.phoneNumberValidator,
                          onFieldSubmitted: (val) {
                            _addressNode.unfocus();
                          })),
                  10.0.h,
                  // BlocBuilder<LoginFormCubit, LoginFormState>(
                  //     bloc: _formCubit,
                  //     builder: (context, state) => EditTextField(
                  //         textInputAction: TextInputAction.next,
                  //         focusNode: _addressNode,
                  //         label: 'Address',
                  //         text: state.address,
                  //         enabled: loginState is! LoadingLoginState,
                  //         errorText: (loginState is FailureLoginState)
                  //             ? loginState.getFromErrors(
                  //                 'address', state.email ?? '')
                  //             : null,
                  //         autofillHints: [AutofillHints.postalAddress],
                  //         onChanged: _formCubit.addressChanged,
                  //         validator: (name) =>
                  //             state.nameValidator(name, title: 'address'),
                  //         onFieldSubmitted: (val) {
                  //           _addressNode.unfocus();
                  //         })),

                  // .0.s,

                  // Spacer(),
                  SizedBox(height: _calculateHeight()),
                  BlocConsumer<ProfileCubit, LoginState>(
                      bloc: _cubit,
                      listener: (context, state) {
                        if (state is ProfileSuccessLoginState) {
                          context.read<AuthBloc>().add(UpdateUser(
                              auth.user!.copyWith(profile: state.data)));
                          CitiDialog.info(Get.context!, 'Success',
                              'Profile updated successfully',
                              buttonLabel: 'Close', button: Navigator.pop);
                        }
                        if (state is UpdateSuccessLoginState) {
                          Navigator.pop(context);
                          context.read<AuthBloc>().add(UpdateUser(state.data ??
                              context.read<AuthBloc>().state.user!));
                          CitiDialog.info(Get.context!, 'Success',
                              'Profile updated successfully',
                              buttonLabel: 'Close', button: Navigator.pop);
                        } else if (state is FailureLoginState) {
                          CitiDialog.showError(context, state.error,
                              overrides: [
                                'first_name',
                                "last_name",
                              ]);
                        }
                      },
                      builder: (c, loginState) =>
                          BlocBuilder<LoginFormCubit, LoginFormState>(
                              bloc: _formCubit,
                              builder: (context, state) => MediumButton(
                                    color: context.primaryColor,
                                    textColor: Colors.white,
                                    label: 'Save Changes',
                                    onPressed: state.isProfileValid &&
                                            (state.firstName !=
                                                    auth.user?.profile
                                                        ?.firstName ||
                                                state.lastName !=
                                                    auth.user?.profile
                                                        ?.lastName)
                                        ? () {
                                            _cubit.updateProfileAlt({
                                              'first_name': state.firstName,
                                              'last_name': state.lastName,
                                            });
                                          }
                                        : null,
                                    varyOpacity: true,
                                    isLoading: loginState is LoadingLoginState,
                                  ))),
                  100.0.h,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  double _calculateHeight() {
    var height = MediaQuery.of(context).size.height;
    print(height - 500);
    var h = 10.0;
    if (height > 670.0) {
      h += height / 7;
    }
    return min(180, h);
  }
}
