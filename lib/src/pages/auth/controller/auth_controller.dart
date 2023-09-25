import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storge_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/ultis_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  void saveTokenAndProceedToBase() {
    // salvar o token
    utilsServices.saveLocalData(key: StorgeKeys.token, data: user.token!);

    // ir para a tela base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> validateToken() async {
    // Recuperando o token que foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorgeKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      sucess: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (menssage) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // zerar o user
    user = UserModel();
    // Remover o token
    await utilsServices.removeLocalData(key: StorgeKeys.token);
    // Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      sucess: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
