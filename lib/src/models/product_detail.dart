/// product : {"id":22,"item_id":"22","group_id":"22","picture":"/files/Product/cat-min.jpeg","arr_picture":"","title":"Cát vệ sinh cho mèo MIN 8L xuất sứ Nhật Bản (Ship nhanh TPHCM)","price":"49900","percent_discount":"0","price_sale":"0","content":"Cát vệ sinh cho mèo MIN 8L xuất sứ Nhật Bản!\r\nTRỌNG LƯỢNG: 3.6KG\r\n\r\nCác tính năng nổi trội của hãng:\r\n\r\n✅ Thấm hút tốt\r\n✅ Vón cục tốt\r\n✅ Ít bụi\r\n✅ Mùi hương dịu nhẹ","num_view":"0","is_free":"0","classify":"Mùi hương"}
/// product_type : [{"id":27,"item_id":"22","picture":"/storage/files/Product/cat-min-chanh.jpeg","title":"Chanh","price":"55000"},{"id":29,"item_id":"22","picture":"/storage/files/Product/cat-min-tao.jpeg","title":"Táo","price":"55000"},{"id":28,"item_id":"22","picture":"/storage/files/Product/cat-min.jpeg","title":"Cà phê CAPPUCCINO","price":"49900"}]
/// product_group : [{"parent_id":"17","title":"Cát vệ sinh  cho Boss"}]

class ProductDetail {
  ProductDetail({
      Product? product, 
      List<ProductType>? productType, 
      List<ProductGroup>? productGroup,}){
    _product = product;
    _productType = productType;
    _productGroup = productGroup;
}

  ProductDetail.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['product_type'] != null) {
      _productType = [];
      json['product_type'].forEach((v) {
        _productType?.add(ProductType.fromJson(v));
      });
    }
    if (json['product_group'] != null) {
      _productGroup = [];
      json['product_group'].forEach((v) {
        _productGroup?.add(ProductGroup.fromJson(v));
      });
    }
  }
  Product? _product;
  List<ProductType>? _productType;
  List<ProductGroup>? _productGroup;
ProductDetail copyWith({  Product? product,
  List<ProductType>? productType,
  List<ProductGroup>? productGroup,
}) => ProductDetail(  product: product ?? _product,
  productType: productType ?? _productType,
  productGroup: productGroup ?? _productGroup,
);
  Product? get product => _product;
  List<ProductType>? get productType => _productType;
  List<ProductGroup>? get productGroup => _productGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    if (_productType != null) {
      map['product_type'] = _productType?.map((v) => v.toJson()).toList();
    }
    if (_productGroup != null) {
      map['product_group'] = _productGroup?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// parent_id : "17"
/// title : "Cát vệ sinh  cho Boss"

class ProductGroup {
  ProductGroup({
      String? parentId, 
      String? title,}){
    _parentId = parentId;
    _title = title;
}

  ProductGroup.fromJson(dynamic json) {
    _parentId = json['parent_id'];
    _title = json['title'];
  }
  String? _parentId;
  String? _title;
ProductGroup copyWith({  String? parentId,
  String? title,
}) => ProductGroup(  parentId: parentId ?? _parentId,
  title: title ?? _title,
);
  String? get parentId => _parentId;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parent_id'] = _parentId;
    map['title'] = _title;
    return map;
  }

}

/// id : 27
/// item_id : "22"
/// picture : "/storage/files/Product/cat-min-chanh.jpeg"
/// title : "Chanh"
/// price : "55000"

class ProductType {
  ProductType({
      num? id, 
      String? itemId, 
      String? picture, 
      String? title, 
      String? price,}){
    _id = id;
    _itemId = itemId;
    _picture = picture;
    _title = title;
    _price = price;
}

  ProductType.fromJson(dynamic json) {
    _id = json['id'];
    _itemId = json['item_id'];
    _picture = json['picture'];
    _title = json['title'];
    _price = json['price'];
  }
  num? _id;
  String? _itemId;
  String? _picture;
  String? _title;
  String? _price;
ProductType copyWith({  num? id,
  String? itemId,
  String? picture,
  String? title,
  String? price,
}) => ProductType(  id: id ?? _id,
  itemId: itemId ?? _itemId,
  picture: picture ?? _picture,
  title: title ?? _title,
  price: price ?? _price,
);
  num? get id => _id;
  String? get itemId => _itemId;
  String? get picture => _picture;
  String? get title => _title;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['picture'] = _picture;
    map['title'] = _title;
    map['price'] = _price;
    return map;
  }

}

/// id : 22
/// item_id : "22"
/// group_id : "22"
/// picture : "/files/Product/cat-min.jpeg"
/// arr_picture : ""
/// title : "Cát vệ sinh cho mèo MIN 8L xuất sứ Nhật Bản (Ship nhanh TPHCM)"
/// price : "49900"
/// percent_discount : "0"
/// price_sale : "0"
/// content : "Cát vệ sinh cho mèo MIN 8L xuất sứ Nhật Bản!\r\nTRỌNG LƯỢNG: 3.6KG\r\n\r\nCác tính năng nổi trội của hãng:\r\n\r\n✅ Thấm hút tốt\r\n✅ Vón cục tốt\r\n✅ Ít bụi\r\n✅ Mùi hương dịu nhẹ"
/// num_view : "0"
/// is_free : "0"
/// classify : "Mùi hương"

class Product {
  Product({
      num? id, 
      String? itemId, 
      String? groupId, 
      String? picture, 
      String? arrPicture, 
      String? title, 
      String? price, 
      String? percentDiscount, 
      String? priceSale, 
      String? content, 
      String? numView, 
      String? isFree, 
      String? classify,}){
    _id = id;
    _itemId = itemId;
    _groupId = groupId;
    _picture = picture;
    _arrPicture = arrPicture;
    _title = title;
    _price = price;
    _percentDiscount = percentDiscount;
    _priceSale = priceSale;
    _content = content;
    _numView = numView;
    _isFree = isFree;
    _classify = classify;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _itemId = json['item_id'];
    _groupId = json['group_id'];
    _picture = json['picture'];
    _arrPicture = json['arr_picture'];
    _title = json['title'];
    _price = json['price'];
    _percentDiscount = json['percent_discount'];
    _priceSale = json['price_sale'];
    _content = json['content'];
    _numView = json['num_view'];
    _isFree = json['is_free'];
    _classify = json['classify'];
  }
  num? _id;
  String? _itemId;
  String? _groupId;
  String? _picture;
  String? _arrPicture;
  String? _title;
  String? _price;
  String? _percentDiscount;
  String? _priceSale;
  String? _content;
  String? _numView;
  String? _isFree;
  String? _classify;
Product copyWith({  num? id,
  String? itemId,
  String? groupId,
  String? picture,
  String? arrPicture,
  String? title,
  String? price,
  String? percentDiscount,
  String? priceSale,
  String? content,
  String? numView,
  String? isFree,
  String? classify,
}) => Product(  id: id ?? _id,
  itemId: itemId ?? _itemId,
  groupId: groupId ?? _groupId,
  picture: picture ?? _picture,
  arrPicture: arrPicture ?? _arrPicture,
  title: title ?? _title,
  price: price ?? _price,
  percentDiscount: percentDiscount ?? _percentDiscount,
  priceSale: priceSale ?? _priceSale,
  content: content ?? _content,
  numView: numView ?? _numView,
  isFree: isFree ?? _isFree,
  classify: classify ?? _classify,
);
  num? get id => _id;
  String? get itemId => _itemId;
  String? get groupId => _groupId;
  String? get picture => _picture;
  String? get arrPicture => _arrPicture;
  String? get title => _title;
  String? get price => _price;
  String? get percentDiscount => _percentDiscount;
  String? get priceSale => _priceSale;
  String? get content => _content;
  String? get numView => _numView;
  String? get isFree => _isFree;
  String? get classify => _classify;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['group_id'] = _groupId;
    map['picture'] = _picture;
    map['arr_picture'] = _arrPicture;
    map['title'] = _title;
    map['price'] = _price;
    map['percent_discount'] = _percentDiscount;
    map['price_sale'] = _priceSale;
    map['content'] = _content;
    map['num_view'] = _numView;
    map['is_free'] = _isFree;
    map['classify'] = _classify;
    return map;
  }

}