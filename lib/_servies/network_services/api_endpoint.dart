class ApiEndpoint {
  static const String baseUrl = 'https://spend-wise-pe9c.onrender.com';

  //-------------Auth-------------//
  static const String authRegister = '/auth/register';
  static const String authVerifyEmail = '/auth/verify-email';
  static const String authResendOTP = '/auth/resend-otp';

  static const String authLogin = '/auth/login';

  static const String authForgotPassword = '/auth/forgot-password';
  static const String authVerifyOTP = '/auth/verify-otp';
  static const String authResetPassword = '/auth/reset-password';

  static const String meAPI = '/user/profile';

  //-------------Account-------------//
  static const String account = '/account';

  //-------------Category-------------//
  static const String category = '/categories';

  //-------------Category-------------//
  static const String transaction = '/transaction';
  static const String transactionTransfer = '/transaction/transfer';
  static const String transactionExpenseUsage = '/transaction/expense-usage';


  //-------------Budgets-------------//
  static const String budget = '/budgets';
}
