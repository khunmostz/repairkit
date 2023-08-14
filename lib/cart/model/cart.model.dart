
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
    String? rentalName;
    String? dayOfRent;
    String? trackingCompany;
    String? trackingProduct;
    bool? acceptItem;

    CartModel({
        this.productImage,
        this.productName,
        this.productAmout,
        this.productRent,
        this.productPrice,
        this.productTotal,
        this.rentalName,
        this.dayOfRent,
        this.trackingCompany,
        this.trackingProduct,
        this.acceptItem,
    });

    CartModel copyWith({
        String? productImage,
        String? productName,
        String? productAmout,
        String? productRent,
        String? productPrice,
        String? productTotal,
        String? rentalName,
        String? dayOfRent,
        String? trackingCompany,
        String? trackingProduct,
        bool? acceptItem,
    }) => 
        CartModel(
            productImage: productImage ?? this.productImage,
            productName: productName ?? this.productName,
            productAmout: productAmout ?? this.productAmout,
            productRent: productRent ?? this.productRent,
            productPrice: productPrice?? this.productPrice,
            productTotal: productTotal ?? this.productTotal,
            rentalName: rentalName ?? this.rentalName,
            dayOfRent: dayOfRent ?? this.dayOfRent,
            trackingCompany: trackingCompany ?? this.trackingCompany,
            trackingProduct: trackingProduct ?? this.trackingProduct,
            acceptItem: acceptItem ?? this.acceptItem,
        );

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productImage: json["productImage"],
        productName: json["productName"],
        productAmout: json["productAmout"],
        productRent: json["productRent"],
        productTotal: json["productTotal"],
        productPrice: json["productPrice"],
        rentalName: json["rentalName"],
        dayOfRent: json["dayOfRent"],
        trackingCompany: json["trackingCompany"],
        trackingProduct: json["trackingProduct"],
        acceptItem: json["acceptItem"],
    );

    Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productName": productName,
        "productAmout": productAmout,
        "productRent": productRent,
        "productTotal": productTotal,
        "productPrice" : productPrice,
        "rentalName": rentalName,
        "dayOfRent": dayOfRent,
        "trackingCompany":trackingCompany,
        "trackingProduct": trackingProduct,
        "acceptItem": acceptItem,
    };
}
