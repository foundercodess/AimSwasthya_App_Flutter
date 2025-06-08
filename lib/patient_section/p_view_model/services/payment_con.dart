// patient_section/p_view_model/services/payment_con.dart
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'doctor_avl_appointment_view_model.dart';
//
// class PaymentViewModel extends ChangeNotifier {
//   Razorpay razorpay = Razorpay();
//
//   PaymentViewModel() {
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
//   }
//
//   void initiatePayment(context,String fees,String phone,dynamic email) {
//     final docAppointmentCon =
//     Provider.of<DoctorAvlAppointmentViewModel>(context,listen: false);
//     print("ashu ${fees}");
//     print("ansssm${email}");
//     print("dlrefrt${phone}");
//     var options = {
//       'key': 'rzp_live_ILgsfZCZoFIKMb',
//       'amount': 5000,
//       'name': 'AimSwasthya',
//       'description': 'Fine T-Shirt',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'prefill': {
//         'contact': 276376746646,
//         'email': "anshg@gmail.com",
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     razorpay.open(options);
//   }
//
//   void _handlePaymentErrorResponse(PaymentFailureResponse response) {
//     _showAlertDialog(
//       "Payment Failed",
//       "Code: ${response.code}\nDescription: ${response.message}\nMetadata: ${response.error.toString()}",
//     );
//   }
//
//   void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
//     _showAlertDialog(
//       "Payment Successful",
//       "Payment ID: ${response.paymentId}",
//     );
//   }
//
//   void _handleExternalWalletSelected(ExternalWalletResponse response) {
//     _showAlertDialog(
//       "External Wallet Selected",
//       "${response.walletName}",
//     );
//   }
//
//   void _showAlertDialog(String title, String message) {
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     razorpay.clear();
//     super.dispose();
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../doctor_avl_appointment_view_model.dart';

class PaymentViewModel extends ChangeNotifier {
  // PhonePe Credentials
  String merchantId = "PGTESTPAYUAT86";
  String callBackURL =
      "https://webhook.site/17d61a6a-69a2-4b8a-8008-d1e15155922d";
  String environment = "PRODUCTION";
  bool enableLogging = true;
  String saltKey = "96434309-7796-489d-8924-ab56988a6076";
  String saltIndex = "1";
  String apiEndPoint = "/pg/v1/pay";
  String checkSumData = "";
  BuildContext? _context;
  // Razorpay Instance
  Razorpay razorpay = Razorpay();

  PaymentViewModel() {
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }


  void payWithPhonePe(
    BuildContext context,
    String fees,
    String phone,
  ) {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "TXN${DateTime.now().millisecondsSinceEpoch}",
      "merchantUserId": "341541541",
      "amount": double.parse(fees) * 100,
      "callbackUrl": callBackURL,
      "mobileNumber": phone,
      "paymentInstrument": {"type": "PAY_PAGE"},
    };
    phonePeInit(context, requestData);
  }

  Future<void> phonePeInit(
      BuildContext context, Map<String, dynamic> payload) async {
    try {
      bool? isInitialized = await PhonePePaymentSdk.init(
          environment, "", merchantId, enableLogging);
      if (isInitialized == true) {
        _generateChecksumAndPay(context, payload);
      } else {
        log("PhonePe SDK Initialization Failed");
      }
    } catch (error) {
      log("PhonePe Init Error: $error");
    }
  }

  void _generateChecksumAndPay(
      BuildContext context, Map<String, dynamic> payload) {
    try {
      String base64Body = base64.encode(utf8.encode(jsonEncode(payload)));
      String checksum =
          "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";
      checkSumData = checksum;
      PhonePePaymentSdk.startTransaction(
        base64Body,
        "",
        checksum,
        "",
      ).then((response) {
        log("PhonePe Payment Response: $response");
        if (response != null) {
          String status = response['status'].toString();
          if (status == "SUCCESS") {
            log("Payment Successful");
          } else {
            log("Payment Failed: $status");
          }
        } else {
          log("Payment Failed: No Response");
        }
      }).catchError((error) {
        log("PhonePe Transaction Error: $error");
      });
    } catch (error) {
      log("Checksum Generation Error: $error");
    }
  }

  //  Razorpay Payment Method
  void payWithRazorpay(
      BuildContext context, String fees, String phone, dynamic email) {
    _context = context;
    log("Fees: $fees, Email: $email, Phone: $phone");
    var options = {
      'key': 'rzp_test_5eYCUMDau2OkQ8',
      'amount': double.parse(fees) * 100,
      'name': 'AimSwasthya',
      'description': 'Service Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': phone, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };
    // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    log("Payment Failed: Code: ${response.code}, Description: ${response.message}");
    final paymentRes = {
      'payment_id': '',
      'message': response.message,
      'code': response.code,
      'error': response.error,
    };

    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(_context!, listen: false);
    Provider.of<DoctorAvlAppointmentViewModel>(_context!, listen: false);
    docAppointmentCon.doctorBookAppointmentApi(
        _context!,
        docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].doctorId,
        docAppointmentCon
            .doctorAvlAppointmentModel!.data!.clinics![0].clinicId,
        paymentRes,
        'razorpay',
        2);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    final paymentRes = {
      'payment_id': response.paymentId,
      'order_id': response.orderId,
      'data': response.data,
      'signature': response.signature,
    };
    log("Payment Successful! Payment ID: ${response.paymentId}");
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(_context!, listen: false);
    docAppointmentCon.doctorBookAppointmentApi(
        _context!,
        docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].doctorId,
        docAppointmentCon
            .doctorAvlAppointmentModel!.data!.clinics![0].clinicId,
        paymentRes,
        'razorpay',
        1);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log("External Wallet Selected: ${response.walletName}");
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }
}
