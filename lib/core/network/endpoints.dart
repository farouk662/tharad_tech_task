class EndPoints{
  EndPoints._(); // private constructor to prevent instantiation
  static const String  baseUrl='https://flutter.tharadtech.com/api/';

  // Auth
  static const String  login='auth/login';
  static const String logout='auth/logout';
  static const String register='auth/register';
  static const String verifyOtp ='otp';

  // Profile
  static const String updateProfile='Update-Profile';
  static const String profileDetails='profile-details';

}