import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'greeting': 'Hello',
      'flutterBoilerPlate': 'Flutter Boilerplate',
      'email': "Email",
      'password': "Password",
      'forGotPassword': "Forgot Password?",
      'login': "LOGIN"
    },
    'th_TH': {
      'greeting': 'สวัสดี',
      'flutterBoilerPlate': 'แม่แบบ Flutter',
      'email': "อีเมล",
      'password': "รหัสผ่าน",
      'forGotPassword': "ลืมรหัสผ่าน?",
      'login': "ล็อคอิน"
    },
    
  };
}
