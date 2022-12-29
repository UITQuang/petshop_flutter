

class AppUrl {
  static const String baseUrl = 'https://meowmeowpetshop.xyz/api/v1/';
  static const String url = 'https://meowmeowpetshop.xyz';
  static const String productList = '${baseUrl}product';
  static const String productHotList = '${baseUrl}product-hot';
  static const String productReduceList = '${baseUrl}product-promotional';
  static const String categoryList = '${baseUrl}category-with-product';
  static const String detailProduct = '${baseUrl}product/';

  //auth

  static const String login = '${baseUrl}login-customer';
  static const String signUp = '${baseUrl}create-customer';
  static const String updateProfile = '${baseUrl}update-customer';
  static const String uploadImage = '${baseUrl}update-image';
  static const String addViewProduct = '${baseUrl}add-num-view-product';
  static const String addToCart = '${baseUrl}add-num-add-to-cart-product';
  static const String postRefund = '${baseUrl}create-refund-order';

  //order
  static const String createOrder = '${baseUrl}order';
  static const String getListOrder = '${baseUrl}get-list-order';
  static const String getDetailOrder = '${baseUrl}get-detail-order';
  static const String getNoticeRefund = '${baseUrl}refund-notice';

  //voucher
  static const String getVoucherList = '${baseUrl}get-voucher-list';
  static const String getVoucherOfUser = '${baseUrl}get-voucher-of-user';
  static const String removeVoucherOfUser = '${baseUrl}remove-voucher';
  static const String getInfoRank = '${baseUrl}info-rank';
  static const String redeemVoucher = '${baseUrl}redeem-voucher';

  //conversation
  static const String createMessage = '${baseUrl}create-message';



}