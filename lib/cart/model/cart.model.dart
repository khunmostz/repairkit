
import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    String? productImage;
    String? productName;
    String? productAmout;
    String? productRent;
    String? productPrice;
    String? productTotal;

    CartModel({
        this.productImage,
        this.productName,
        this.productAmout,
        this.productRent,
        this.productPrice,
        this.productTotal,
    });

    CartModel copyWith({
        String? productImage,
        String? productName,
        String? productAmout,
        String? productRent,
        String? productPrice,
        String? productTotal,
    }) => 
        CartModel(
            productImage: productImage ?? this.productImage,
            productName: productName ?? this.productName,
            productAmout: productAmout ?? this.productAmout,
            productRent: productRent ?? this.productRent,
            productPrice: productPrice?? this.productPrice,
            productTotal: productTotal ?? this.productTotal,
        );

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productImage: json["productImage"],
        productName: json["productName"],
        productAmout: json["productAmout"],
        productRent: json["productRent"],
        productTotal: json["productTotal"],
        productPrice: json["productPrice"],
    );

    Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productName": productName,
        "productAmout": productAmout,
        "productRent": productRent,
        "productTotal": productTotal,
        "productPrice" : productPrice,
    };
}
