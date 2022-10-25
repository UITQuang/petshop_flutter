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
/// group : {"id":22,"group_id":"0","parent_id":"17","picture":"","title":"Cát vệ sinh  cho Boss","meta_title":"","meta_key":"","meta_desc":""}

class ProductModel {
  ProductModel({
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
      String? classify, 
      Group? group,}){
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
    _group = group;
}

  ProductModel.fromJson(dynamic json) {
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
    _group = json['group'] != null ? Group.fromJson(json['group']) : null;
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
  Group? _group;
ProductModel copyWith({  num? id,
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
  Group? group,
}) => ProductModel(  id: id ?? _id,
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
  group: group ?? _group,
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
  Group? get group => _group;

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
    if (_group != null) {
      map['group'] = _group?.toJson();
    }
    return map;
  }

}

/// id : 22
/// group_id : "0"
/// parent_id : "17"
/// picture : ""
/// title : "Cát vệ sinh  cho Boss"
/// meta_title : ""
/// meta_key : ""
/// meta_desc : ""

class Group {
  Group({
      num? id, 
      String? groupId, 
      String? parentId, 
      String? picture, 
      String? title, 
      String? metaTitle, 
      String? metaKey, 
      String? metaDesc,}){
    _id = id;
    _groupId = groupId;
    _parentId = parentId;
    _picture = picture;
    _title = title;
    _metaTitle = metaTitle;
    _metaKey = metaKey;
    _metaDesc = metaDesc;
}

  Group.fromJson(dynamic json) {
    _id = json['id'];
    _groupId = json['group_id'];
    _parentId = json['parent_id'];
    _picture = json['picture'];
    _title = json['title'];
    _metaTitle = json['meta_title'];
    _metaKey = json['meta_key'];
    _metaDesc = json['meta_desc'];
  }
  num? _id;
  String? _groupId;
  String? _parentId;
  String? _picture;
  String? _title;
  String? _metaTitle;
  String? _metaKey;
  String? _metaDesc;
Group copyWith({  num? id,
  String? groupId,
  String? parentId,
  String? picture,
  String? title,
  String? metaTitle,
  String? metaKey,
  String? metaDesc,
}) => Group(  id: id ?? _id,
  groupId: groupId ?? _groupId,
  parentId: parentId ?? _parentId,
  picture: picture ?? _picture,
  title: title ?? _title,
  metaTitle: metaTitle ?? _metaTitle,
  metaKey: metaKey ?? _metaKey,
  metaDesc: metaDesc ?? _metaDesc,
);
  num? get id => _id;
  String? get groupId => _groupId;
  String? get parentId => _parentId;
  String? get picture => _picture;
  String? get title => _title;
  String? get metaTitle => _metaTitle;
  String? get metaKey => _metaKey;
  String? get metaDesc => _metaDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['group_id'] = _groupId;
    map['parent_id'] = _parentId;
    map['picture'] = _picture;
    map['title'] = _title;
    map['meta_title'] = _metaTitle;
    map['meta_key'] = _metaKey;
    map['meta_desc'] = _metaDesc;
    return map;
  }

}