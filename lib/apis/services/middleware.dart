import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_php/apis/services/services.dart';

SettingServices myServices = Get.find();

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;
  SettingServices myServices = Get.find();
  RouteSettings? redirect(String? route) {
    // if(myServices.sharedPrefer.getString("onboarding") == "1"){
    //   return const RouteSettings(name: AppRoute.login) ;
    // }}
    myServices.sharedPrefer.setString("id", "id");
    //  if(myServices.sharedPrefer.getString("finishLogin") == "1"){
    //    return const RouteSettings(name: AppRoute.viewNotes) ;
    //  }
  }
}

// class AppRoute {
//   static const String login = "/login";
//   static const String onBoarding = "/onboarding";
//   static const String signUp = "/signup";
//   static const String forgetPassword = "/forgetpassword";
//   static const String verfiyCode = "/verfiycode";
//   static const String resetPassword = "/resetpassword";
//   static const String successSignUp = "/successsignup";
//   static const String successResetpassword = "/successresetpassword";
//   static const String checkemail = "/checkemail";
//   static const String verfiyCodeSignUp = "/verfiycodesignup";
//   static const String viewNotes = "/viewNotes";
//   static const String addNotes = "/addNotes";
// }
// List<GetPage<dynamic>>? routes = [
//   GetPage(name: "/", page: () => AppLanguage() , middlewares: [MyMiddleWare()]),
//   // GetPage(name: "/", page: () => Test()),
//   GetPage(name: AppRoute.login, page: () => SignIn()),
//   GetPage(name: AppRoute.signUp, page: () =>  SignUp()),
//   GetPage(name: AppRoute.forgetPassword, page: () => ForgetPassword()),
//   GetPage(name: AppRoute.verfiyCode, page: () =>  VerfiyCode()),
//   GetPage(name: AppRoute.resetPassword, page: () =>  resetPassword()),
//   GetPage(name: AppRoute.viewNotes, page: () =>  viewNotesScreen()),
//   GetPage(name: AppRoute.addNotes, page: () =>  addNotesScreen()),
//   // GetPage(name: AppRoute.successResetpassword, page: () => const SuccessResetPassword()),
//   // GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
//   // GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
//   // GetPage(name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
// ];
