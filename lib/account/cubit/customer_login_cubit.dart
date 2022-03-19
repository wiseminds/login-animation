import 'package:auth/cubit/login_cubit.dart';
import 'package:common/common.dart';
import 'package:common/models/error_model.dart';
import 'package:common/widgets/citi_dialog.dart';
import 'package:customer/services/social_auth/social_login.dart';
import 'package:customer/services/social_auth/widget/social_button.dart';
import 'package:customer/views/account/cubit/customer_login_repository.dart';
import 'package:flutter/material.dart';

class CustomerLoginCubit extends LoginCubit {
  CustomerLoginCubit()
      : repository = CustomerLoginRepository(),
        super(CustomerLoginRepository());

  final CustomerLoginRepository repository;

  void social(SocialOptions option, SocialAuthResult result) async {
    emit(LoadingLoginState());
    if (!result.isSuccessfull) {
      emit(FailureLoginState(ErrorModel(message: result.message), {}));
      return;
    }
    emit(LoadingLoginState());
    CitiDialog.showLoadingDialog(Get.context!);
    var response = await repository.social(option, result);
    Navigator.pop(Get.context!);
    handleAuth(response);
  }
}
