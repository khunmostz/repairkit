import 'package:get/get.dart';

class PaymentController extends GetxController{
  String token = '';
  void setOmiseToken(String value){
    token = value;
  }
}