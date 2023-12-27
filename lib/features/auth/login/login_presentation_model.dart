import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : loginResult = const FutureResult.empty(),
        userName = '',
        userPassword = '';

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.loginResult,
    required this.userName,
    required this.userPassword,
  });

  final FutureResult<Either<LogInFailure, User>> loginResult;

  @override
  String userName;

  @override
  String userPassword;

  @override
  bool isLoginEnabled = false;

  @override
  bool get isLoading => loginResult.isPending();

  LoginPresentationModel copyWith(
    FutureResult<Either<LogInFailure, User>>? loginResult,
  ) {
    return LoginPresentationModel._(
      loginResult: loginResult ?? this.loginResult,
      userName: userName,
      userPassword: userPassword,
    )..isLoginEnabled = isLoginEnabled;
  }

  @override
  void userNameChanged(String val) {
    // Update userName when username changes
    userName = val;
    isLoginEnabled = userName.isNotEmpty && userPassword.isNotEmpty;
  }

  @override
  void passwordChanged(String val) {
    // Update userPassword when password changes
    userPassword = val;
    isLoginEnabled = userName.isNotEmpty && userPassword.isNotEmpty;
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool isLoginEnabled = false;

  late String userName;
  late String userPassword;

  bool get isLoading;

  void userNameChanged(String val);
  void passwordChanged(String val);
}
