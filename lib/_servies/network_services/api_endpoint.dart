class ApiEndpoint {
  static const String baseUrl = 'https://spend-wise-pe9c.onrender.com';
  static const String baseUrl2 = 'https://spendwise-r1l1.onrender.com/api/v1';

  //-------------Auth-------------//
  static const String authRegister = '/auth/register';
  static const String authVerifyEmail = '/auth/verify-email';
  static const String authLogin = '/auth/login';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authVerifyOTP = '/auth/verify-otp';
  static const String authResetPassword = '/auth/reset-password';
  //-------------Aut2-------------//
  static const String authRegister2 = '/auth/register';
  static const String authVerifyEmail2 = '/auth/verify-email';
  static const String authResendOTP2 = '/auth/resend-otp';

  static const String authLogin2 = '/auth/login';

  static const String authForgotPassword2 = '/auth/forgot-password';
  static const String authVerifyOTP2 = '/auth/verify-otp';
  static const String authResetPassword2 = '/auth/reset-password';

  static const String meAPI = '/auth/me';

  //-------------Account-------------//
  static const String account = '/account';

  //-------------Category-------------//
  static const String category = '/category';

  //-------------Category-------------//
  static const String transaction = '/transaction';
}
