

class AppUrl {
  static const String baseUrl = 'https://meowmeowpetshop.xyz/api/v1/';
  static const String url = 'https://meowmeowpetshop.xyz';
  static const String productList = '${baseUrl}product';
  static const String productHotList = '${baseUrl}product-hot';
  static const String categoryList = '${baseUrl}category-with-product';
  static const String detailProduct = '${baseUrl}product/';

  //auth

  static const String login = '${baseUrl}login-customer';
  static const String signUp = '${baseUrl}create-customer';
  static const String updateProfile = '${baseUrl}update-customer';
  static const String uploadImage = '${baseUrl}update-image';
  static const String addViewProduct = '${baseUrl}add-num-view-product';
  static const String addToCart = '${baseUrl}add-num-add-to-cart-product';

  //order
  static const String createOrder = '${baseUrl}order';
  static const String getListOrder = '${baseUrl}get-list-order';
  static const String getDetailOrder = '${baseUrl}get-detail-order';


}