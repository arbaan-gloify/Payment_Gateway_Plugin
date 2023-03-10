import 'package:flutter/material.dart';

import 'firebase_analytics/firebase_analyt.dart';
import 'razorpay_gateway/razorpay.dart';
import 'upi_gateway/upi_payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirebasePluginAnalytics(),
    );
  }
}
