import 'package:auth/cubit/login_cubit.dart';
import 'package:customer/views/account/cubit/customer_login_repository.dart';

class ProfileCubit extends LoginCubit {
  ProfileCubit() : super(CustomerLoginRepository());

  final CustomerLoginRepository _repository = CustomerLoginRepository();

  void updateProfileAlt(Map<String, dynamic> body,
      [bool isFile = false]) async {
    emit(LoadingLoginState());
    var response = await _repository.updateProfileAlt(body, isFile);

    if (response.isSuccessful) {
      emit(ProfileSuccessLoginState(response.body));
    } else {
      emit(FailureLoginState(getError(response), response.request?.body ?? {}));
    }
  }
}
