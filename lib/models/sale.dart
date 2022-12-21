class Sale {
  int? saleId;
  String? saleProductList;
  int? saleTotalAmount;
  int? saleNoOfItems;
  String? saleDate;

  Sale(
      {this.saleId,
      this.saleProductList,
      this.saleTotalAmount,
      this.saleNoOfItems,
      this.saleDate});

  // Convert note object to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['saleId'] = this.saleId;
    map['saleProductList'] = this.saleProductList;
    map['salePTotalPrice'] = this.saleTotalAmount;
    map['saleNoOfitems'] = this.saleNoOfItems;
    map['saleDate'] = this.saleDate;

    return map;
  }

  // Extract note object from map
  Sale.fromMap(Map<String, dynamic> map) {
    this.saleId = map['saleId'];
    this.saleProductList = map['saleProductList'];
    this.saleTotalAmount = map['salePTotalPrice'];
    this.saleNoOfItems = map['saleNoOfitems'];
    this.saleDate = map['saleDate'];
  }
}
