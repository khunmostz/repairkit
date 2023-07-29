// To parse this JSON data, do
//
//     final receiveProductModel = receiveProductModelFromJson(jsonString);

import 'dart:convert';

ReceiveProductModel receiveProductModelFromJson(String str) => ReceiveProductModel.fromJson(json.decode(str));

String receiveProductModelToJson(ReceiveProductModel data) => json.encode(data.toJson());

class ReceiveProductModel {
    String? rentDay;
    String? uid;
    String? product;
    String? productAmount;
    bool? acceptItem;
    String? productImage;
    String? docId;
    String? trackingCompany;
    String? rentalName;
    String? trackingProduct;

    ReceiveProductModel({
        this.rentDay,
        this.uid,
        this.product,
        this.productAmount,
        this.acceptItem,
        this.productImage,
        this.docId,
        this.trackingCompany,
        this.rentalName,
        this.trackingProduct,
    });

    ReceiveProductModel copyWith({
        String? rentDay,
        String? uid,
        String? product,
        String? productAmount,
        bool? acceptItem,
        String? productImage,
        String? docId,
        String? trackingCompany,
        String? rentalName,
        String? trackingProduct,
    }) => 
        ReceiveProductModel(
            rentDay: rentDay ?? this.rentDay,
            uid: uid ?? this.uid,
            product: product ?? this.product,
            productAmount: productAmount ?? this.productAmount,
            acceptItem: acceptItem ?? this.acceptItem,
            productImage: productImage ?? this.productImage,
            docId: docId ?? this.docId,
            trackingCompany: trackingCompany ?? this.trackingCompany,
            rentalName: rentalName ?? this.rentalName,
            trackingProduct: trackingProduct ?? this.trackingProduct,
        );

    factory ReceiveProductModel.fromJson(Map<String, dynamic> json) => ReceiveProductModel(
        rentDay: json["rentDay"],
        uid: json["uid"],
        product: json["product"],
        productAmount: json["productAmount"],
        acceptItem: json["acceptItem"],
        productImage: json["productImage"],
        docId: json["docId"],
        trackingCompany: json["trackingCompany"],
        rentalName: json["rentalName"],
        trackingProduct: json["trackingProduct"],
    );

    Map<String, dynamic> toJson() => {
        "rentDay": rentDay,
        "uid": uid,
        "product": product,
        "productAmount": productAmount,
        "acceptItem": acceptItem,
        "productImage": productImage,
        "docId": docId,
        "trackingCompany": trackingCompany,
        "rentalName": rentalName,
        "trackingProduct": trackingProduct,
    };
}
