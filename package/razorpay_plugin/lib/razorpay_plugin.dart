library razorpay_plugin;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyRazorpayPlugin {

  void openCheckout({
    required String keyId,
    required int amount,
    required String name,
    required String description,
    required String email,
    required int contact,
  }) async {
    Razorpay razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    Map<String, dynamic> options = {
      'key': keyId,
      'amount': amount,
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email}
    };

    try {
      razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log('${response.paymentId},${response.orderId},${response.signature}');
    Fluttertoast.showToast(
      msg: "Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // _channel.invokeMethod('paymentError', response);
    log('${response.message},${response.error},${response.code}');
    Fluttertoast.showToast(
      msg: "Failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('${response.walletName},');
    Fluttertoast.showToast(
      msg: "External Walled",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}


class UpiPlugin{

}