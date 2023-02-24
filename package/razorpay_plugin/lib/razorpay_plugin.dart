library razorpay_plugin;

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyRazorpayPlugin {
  static const MethodChannel _channel = MethodChannel('my_razorpay_plugin');

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

  static void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _channel.invokeMethod('paymentSuccess', response);
  }

  static void _handlePaymentError(PaymentFailureResponse response) {
    _channel.invokeMethod('paymentError', response);
  }

  static void _handleExternalWallet(ExternalWalletResponse response) {
    _channel.invokeMethod('externalWallet', response);
  }
}
