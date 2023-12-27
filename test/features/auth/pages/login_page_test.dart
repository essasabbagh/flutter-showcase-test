import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_page.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late LoginPage page;
  late LoginInitialParams initParams;
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late LoginNavigator navigator;
  late LogInUseCase useCase;

  void initMvp() {
    initParams = const LoginInitialParams();
    model = LoginPresentationModel.initial(
      initParams,
    );
    navigator = LoginNavigator(Mocks.appNavigator);
    useCase = LogInUseCase(UserStore(user: const User.anonymous()));
    presenter = LoginPresenter(
      model,
      navigator,
      useCase,
    );
    page = LoginPage(presenter: presenter);
  }

  await screenshotTest(
    "login_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<LoginPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
