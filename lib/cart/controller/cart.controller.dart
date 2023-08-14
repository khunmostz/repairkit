import 'package:flutter_boilerplate/cart/model/cart.model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //#region variable
  List<CartModel>? cartList = [];
  int? totalCart = 0;
  //#endregion variable

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    calculateTotalCart();
  }

  //#region logic
  void removeItemCart(int index) {
    cartList?.removeAt(index);
    update();
  }

  void addItemCart(CartModel cartItem) {
    cartList?.add(cartItem);
    update();
  }

  Future<void> calculateTotalCart() async {
    totalCart = 0;
    if (cartList != null && cartList!.isNotEmpty) {
      cartList!.forEach((element) {
        totalCart = (totalCart ?? 0) + int.parse(element.productTotal ?? '0');
      });
      update();
    }
  }
  //#endregion logic
}
