import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/base/widget/custom_toast.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/payment/controller/payment.controller.dart';
import 'package:flutter_boilerplate/payment/service/omise.service.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:awesome_card/awesome_card.dart';

class Payment extends StatefulWidget {
  Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController cardNameController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController expController = TextEditingController();

  TextEditingController cvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        onBackPress: () => Get.back(),
        showCart: false,
        titleName: 'Credit Card',
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 10),
                  child: CreditCard(
                    cardNumber: cardNumberController.text,
                    cardExpiry: expController.text,
                    cardHolderName: cardNameController.text,
                    cvv: cvcController.text,
                    bankName: "Mastercard",
                    cardType: CardType
                        .masterCard, // Optional if you want to override Card Type
                    showBackSide: false,
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    // showShadow: true,
                  ),
                ),
                CustomTextFormField(
                  label: 'Cardname',
                  controller: cardNameController,
                  hintText: 'JOHN DOE',
                  showBorder: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                CustomTextFormField(
                  label: 'Cardnumber',
                  controller: cardNumberController,
                  hintText: '4242-4242-4242-4242',
                  inputFormatters: [
                    CreditCardNumberInputFormatter(),
                    LengthLimitingTextInputFormatter(19)
                  ],
                  showBorder: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                CustomTextFormField(
                  label: 'Exp',
                  controller: expController,
                  hintText: '01/12',
                  showBorder: true,
                  inputFormatters: [
                    CreditCardExpirationDateFormatter(),
                  ],
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                CustomTextFormField(
                  label: 'CVC',
                  controller: cvcController,
                  hintText: '123',
                  showBorder: true,
                  inputFormatters: [
                    CreditCardCvcInputFormatter(),
                  ],
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: CustomButton(
                    text: 'Confirm',
                    onTap: () async {
                      await OmiseService()
                          .getToken(
                        cardName: cardNameController.text,
                        cardNumber: cardNumberController.text,
                        expMonth: int.parse(expController.text.split('/')[0]),
                        expYear: int.parse(expController.text.split('/')[1]),
                        cvc: int.parse(cvcController.text),
                      )
                          .then((value) async {
                        var response = await OmiseService().chargesCard(
                          description:
                              'Buy with ${FirebaseAuth.instance.currentUser?.email}',
                          amount: Get.find<CartController>().totalCart.toString(),
                        );
                        // print(response);
                
                        if (mounted && response['status'] == 'successful') {
                      
                          Get.offNamed(RouteConstants.paymentSuccessful);
                        } else {
                          showToast(
                            context,
                            toastText: 'Payment failed',
                            status: ToastStatus.ERROR,
                          );
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
