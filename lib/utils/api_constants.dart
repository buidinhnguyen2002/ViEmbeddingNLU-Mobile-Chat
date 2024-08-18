class API {
  static const l1 = '192.168.1.5';
  static const l2 = '192.168.0.193';
  static const feel = '192.168.1.24';
  static const khoa = '10.50.90.139';
  // nha
  static const nha1 = '192.168.64.1';
  static const ntro = '192.168.1.29';
  static const nfeel = '192.168.1.32';
  static const baseUrlAPI = 'http://192.168.0.161:8068';
  static const String signup = '$baseUrlAPI/guest/signup';
  static const String login = '$baseUrlAPI/guest/login';
  static const String refreshToken = '$baseUrlAPI/guest/refresh-token';
  static const String resendVerifyToken =
      '$baseUrlAPI/guest/resend-verify-token';
  static const String verifyForgotPass = '$baseUrlAPI/guest/verify-forgot-pass';
  static const String acceptForgotPass = '$baseUrlAPI/guest/accept-forgot-pass';
  static const String forgotPass = '$baseUrlAPI/guest/forgot-pass';
  static const String verifyToken = '$baseUrlAPI/guest/verify-token';
  static const String logout = '$baseUrlAPI/api/v1/auth/logout';
  static const String authVerifyToken = '$baseUrlAPI/api/v1/auth/check-token';
  static const String getUserInfo = '$baseUrlAPI/api/v1/users/me';
  static const String getBots = '$baseUrlAPI/api/v1/users/bots';
  static const String getKnowledge = '$baseUrlAPI/api/v1/users/knowledges';
  static const String updatePassword = '$baseUrlAPI/api/v1/users/change-pass';
  static const String bots = '$baseUrlAPI/api/v1/bots';
  static const String knowledges = '$baseUrlAPI/api/v1/knowledges';
  static const String chatsBot = '$baseUrlAPI/api/v1/chats-bot';
  static const String updateUser = '$baseUrlAPI/api/v1/users/update';
  static const String chatQueries = '$baseUrlAPI/api/v1/queries/bots';
  static const String knowledgeBot = '$baseUrlAPI/api/v1/knowledges-bot';
}
