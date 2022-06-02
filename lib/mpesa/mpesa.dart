// import 'package:mpesa/mpesa.dart';

// void main() {
//   final mpesa = Mpesa(
//     clientKey: "4EWfVXdxZXD2LwrS9GCq9ef3JMObwaQe",
//     clientSecret: "H90qZoIpYeIQoeNZ",
//     passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
//     environment: "sandbox",
//   );

//   mpesa
//       .lipaNaMpesa(
//         phoneNumber: "",
//         amount: 1,
//         businessShortCode: 174379,
//         callbackUrl: "https://30d6-154-123-30-14.in.ngrok.io",
//       )
//       .then((result) {})
//       .catchError((error) {});
// }
// Headers
// Key: Authorization
// Value: Basic NEVXZlZYZHhaWEQyTHdyUzlHQ3E5ZWYzSk1PYndhUWU6SDkwcVpvSXBZZUlRb2VOWg==
// ​
// Body
//   {
//     "BusinessShortCode": 174379,
//     "Password": "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjIwNTMxMTcwNjM1",
//     "Timestamp": "20220531170635",
//     "TransactionType": "CustomerPayBillOnline",
//     "Amount": 10,
//     "PartyA": 254708374149,
//     "PartyB": 174379,
//     "PhoneNumber": 254791784445,
//     "CallBackURL": "https://mydomain.com/path",
//     "AccountReference": "CompanyXLTD",
//     "TransactionDesc": "Payment of X" 
//   }

// {
//   "MerchantRequestID": "82116-81326917-1",
//   "CheckoutRequestID": "ws_CO_31052022170807213791784445",
//   "ResponseCode": "0",
//   "ResponseDescription": "Success. Request accepted for processing",
//   "CustomerMessage": "Success. Request accepted for processing"
// }
//  return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         primary: Colors.green,
//         padding: EdgeInsets.all(10),
//       ),
//       onPressed: () {
//         productProvider.userModelList
//             .map((e) => {
//                   if (productProvider.getCheckOutModelList.isNotEmpty)
//                     {
//                       FirebaseFirestore.instance.collection("Order").add({
//                         "Product": productProvider.getCheckOutModelList
//                             .map((c) => {
//                                   "ProductName": c.name,
//                                   "ProductPrice": c.price,
//                                   "ProductQuantity": c.quantity,
//                                   "ProductImage": c.image,
//                                 })
//                             .toList(),
//                         "TotalPrice": total,
//                         "UserName": e.userName,
//                         "UserEmail": e.email,
//                         "UserNumber": e.phoneNo,
//                         "UserAddress": e.address,
//                         "UserId": user.uid,
//                       }),
//                       setState(() {
//                         myList.clear();
//                       }),
//                       productProvider.addNotification("Notification"),
//                     }
//                   else
//                     {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("No Item Added"),
//                         ),
//                       ),
//                     }
//                 })
//             .toList();
//       },
//       child: const Text(
//         'Proceed to pay',
//         style: TextStyle(
//             fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
//       ),
//     );