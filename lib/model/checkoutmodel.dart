class CheckoutModel {
  final int total;
  final int phoneNo;
  final String address;
  final String productName;
  final int quantity;
  CheckoutModel(
      {required this.total,
      required this.phoneNo,
      required this.address,
      required this.productName,
      required this.quantity});
}
