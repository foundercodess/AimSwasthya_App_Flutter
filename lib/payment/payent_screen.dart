//
// import 'dart:convert';
// import 'dart:developer';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
//
// class PhonePePaymentScreen extends StatefulWidget {
//   @override
//   _PhonePePaymentScreenState createState() => _PhonePePaymentScreenState();
// }
//
// class _PhonePePaymentScreenState extends State<PhonePePaymentScreen> {
//   // PhonePe Credentials
//   String merchantId = "PGTESTPAYUAT";
//   String callBackURL = "https://webhook.site/17d61a6a-69a2-4b8a-8008-d1e15155922d";
//   String environment = "PRODUCTION";
//   bool enableLogging = true;
//   String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
//   String saltIndex = "1";
//   String apiEndPoint = "/pg/v1/pay";
//   String checkSumData = "";
//
//   // Initialize PhonePe SDK
//   void phonePeInit(BuildContext context, Map<String, dynamic> payload) {
//     PhonePePaymentSdk.init(environment, "", merchantId, enableLogging).then((val) {
//       _generateChecksumAndPay(context, payload);
//     }).catchError((error) {
//       log("PhonePe SDK Init Error: $error");
//     });
//   }
//
//   // Generate Checksum and Start Payment
//   void _generateChecksumAndPay(BuildContext context, Map<String, dynamic> payload) {
//     try {
//       String base64Body = base64.encode(utf8.encode(jsonEncode(payload)));
//       String checksum = "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";
//       setState(() {
//         checkSumData = checksum;
//       });
//
//       // Start Transaction
//       PhonePePaymentSdk.startTransaction(
//         base64Body,
//         "",
//         checksum,
//         "",
//       ).then((response) {
//         log("PhonePe Payment Response: $response");
//         if (response != null) {
//           String status = response['status'].toString();
//           if (status == "SUCCESS") {
//             log("Payment Successful");
//           } else {
//             log("Payment Failed: $status");
//           }
//         } else {
//           log("Payment Failed: No Response");
//         }
//       }).catchError((error) {
//         log("PhonePe Transaction Error: $error");
//       });
//
//     } catch (error) {
//       log("Checksum Generation Error: $error");
//     }
//   }
//
//   Widget phonePeButton() {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xff6739B7), // PhonePe brand color
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       onPressed: () {
//         final requestData = {
//           "merchantId": merchantId,
//           "merchantTransactionId": "TXN123456789",
//           "merchantUserId": "1",
//           "amount": 100, // Amount in Paisa (₹1.00)
//           "callbackUrl": callBackURL,
//           "mobileNumber": "9876543210",
//           "paymentInstrument": {"type": "PAY_PAGE"},
//         };
//         phonePeInit(context, requestData);
//       },
//       child: const Text(
//         "Pay using PhonePe",
//         style: TextStyle(fontSize: 16, color: Colors.white),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("PhonePe Payment")),
//       body: Center(child: phonePeButton()),
//     );
//   }
// }
