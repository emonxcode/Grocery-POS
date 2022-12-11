import 'package:flutter/material.dart';

class Product {
  String? pId;
  String? pName;
  String? pDesc;
  String? pImgUrl;
  int? pSalePrice;
  int? pBuyingPrice;
  int? pQuantity;
  String? pBrand;
  String? pSupplier;

  Product(
      {
    
      this.pName,
      this.pDesc,
      this.pSalePrice,
      this.pBuyingPrice,
      this.pQuantity,
      this.pImgUrl,
      this.pBrand,
      this.pSupplier});

  // Convert note object to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();



    map['pName'] = this.pName;
    map['pDesc'] = this.pDesc;
    map['pImgUrl'] = this.pImgUrl;
    map['pSalePrice'] = this.pSalePrice;
    map['pBuyingPrice'] = this.pBuyingPrice;
    map['pQuantity'] = this.pQuantity;
    map['pBrand'] = this.pBrand;
    map['pSupplier'] = this.pSupplier;

    return map;
  }

  // Extract note object from map
  Product.fromMap(Map<String, dynamic> map) {

    this.pName = map['pName'];
    this.pDesc = map['pDesc'];
    this.pImgUrl = map['pImgUrl'];
    this.pSalePrice = map['pSalePrice'];
    this.pBuyingPrice = map['pBuyingPrice'];
    this.pQuantity = map['pQuantity'];
    this.pBrand = map['pBrand'];
    this.pSupplier = map['pSupplier'];
  }
}
