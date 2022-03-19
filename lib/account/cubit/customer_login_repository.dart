import 'package:auth/cubit/login_repository.dart';
import 'package:auth/views/account/success_screen.dart';
import 'package:common/common.dart';
import 'package:common/data/remote/provider/api_response.dart';
import 'package:common/models/profile.dart';
import 'package:common/models/user.dart';
import 'package:common/modules/account/bloc/auth/auth_bloc.dart';
import 'package:customer/data/api_services/authentication_service.dart';
import 'package:customer/services/social_auth/social_login.dart';
import 'package:customer/services/social_auth/widget/social_button.dart';
import 'package:customer/views/account_status_bulder.dart';
import 'package:customer/views/auth_builder.dart';

class CustomerLoginRepository extends LoginRepository {
  final AuthenticationService _apiService = AuthenticationService();
  @override
  Future<ApiResponse<User, User>> login(String email, String password) =>
      _apiService.login<User>(email, password);

  @override
  Future<ApiResponse<User, User>> register(Map<String, dynamic> body) =>
      _apiService.register<User>(body);

  @override
  void navigate(User user, String token, [bool fromRegister = false]) async {
    GetIt.I<AuthBloc>().add(LoggedIn(user, token: token));
    await Future.delayed(100.toDurationInMilliseconds);
    Get.offAll(() => const AuthBuilder(child: AccountStatusBuilder()));

    if (fromRegister) {
      Get.to(() => const SuccessScreen(
            title: 'Great Job!',
            subtitle:
                'Your account has been created successfully, please verify your account to continue.',
            buttonLabel: 'Verify Account',
          ));
    }
  }

  @override
  Future<ApiResponse<User, User>> updateProfile(Map<String, dynamic> body,
      [bool isFile = false]) {
    return _apiService.updateProfile(body, isFile);
  }

  Future<ApiResponse<Profile, Profile>> updateProfileAlt(
      Map<String, dynamic> body,
      [bool isFile = false]) {
    return _apiService.updateProfileAlt(body, isFile);
  }

    Future<ApiResponse<User, User>> social( SocialOptions option, SocialAuthResult result) {
    return _apiService.socialLogin(option, result);
  }

  @override
  Future<ApiResponse<User, User>> getProfile() async {
    var response = await _apiService.getProfile();
    if (response.isSuccessful && response.body != null) {
      GetIt.I<AuthBloc>().add(UpdateUser(response.body!));
    }
    return response;
  }

  @override
  Future<ApiResponse<Profile, Profile>> getProfileMerchant() {
    // TODO: implement getProfileMerchant
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<Profile, Profile>> updateMerchantProfile(
      Map<String, dynamic> body,
      [bool isFile = false]) {
    // TODO: implement updateMerchantProfile
    throw UnimplementedError();
  }
}
