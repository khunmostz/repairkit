class ProductModel {
  int? rentalId;
  String? productCategory;
  String? productName;
  int? productPrice;
  DateTime? productDate;
  int? productAmount;
  String? productInfo;
  String? productImage;
  int? rating;

  ProductModel({
    this.rentalId,
    this.productCategory,
    this.productName,
    this.productPrice,
    this.productDate,
    this.productAmount,
    this.productInfo,
    this.productImage,
    this.rating,
  });

  ProductModel copyWith({
    int? rentalId,
    String? productCategory,
    String? productName,
    int? productPrice,
    DateTime? productDate,
    int? productAmount,
    String? productInfo,
    String? productImage,
    int? rating,
  }) =>
      ProductModel(
        rentalId: this.rentalId ?? rentalId,
        productCategory: this.productCategory ?? productCategory,
        productName: this.productName ?? productName,
        productPrice: this.productPrice ?? productPrice,
        productDate: this.productDate ?? productDate,
        productAmount: this.productAmount ?? productAmount,
        productInfo: this.productInfo ?? productInfo,
        productImage: this.productImage ?? productImage,
        rating: this.rating ?? rating,
      );
}
