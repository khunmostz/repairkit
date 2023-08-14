import 'dart:convert';

RentalModel rentalModelFromJson(String str) => RentalModel.fromJson(json.decode(str));

String rentalModelToJson(RentalModel data) => json.encode(data.toJson());

class RentalModel {
    dynamic rentalId;
    String? rentalName;
    String? rentalPhone;
    String? rentalAddress;
    String? rentalImage;

    RentalModel({
        this.rentalId,
        this.rentalName,
        this.rentalPhone,
        this.rentalAddress,
        this.rentalImage,
    });

    RentalModel copyWith({
        dynamic rentalId,
        String? rentalName,
        String? rentalPhone,
        String? rentalAddress,
        String? rentalImage,
    }) => 
        RentalModel(
            rentalId: rentalId ?? this.rentalId,
            rentalName: rentalName ?? this.rentalName,
            rentalPhone: rentalPhone ?? this.rentalPhone,
            rentalAddress: rentalAddress ?? this.rentalAddress,
            rentalImage: rentalImage ?? this.rentalImage,
        );

    factory RentalModel.fromJson(Map<String, dynamic> json) => RentalModel(
        rentalId: json["rentalId"],
        rentalName: json["rentalName"],
        rentalPhone: json["rentalPhone"],
        rentalAddress: json["rentalAddress"],
        rentalImage: json["rentalImage"],
    );

    Map<String, dynamic> toMap() => {
        "rentalId": rentalId,
        "rentalName": rentalName,
        "rentalPhone": rentalPhone,
        "rentalAddress": rentalAddress,
        "rentalImage": rentalImage,
    };
    String toJson() => json.encode(toMap());
}
