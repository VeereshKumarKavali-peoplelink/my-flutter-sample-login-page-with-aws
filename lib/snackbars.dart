

import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar mySnackBar({required String title, required String message}){
  return GetSnackBar(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(16),
    borderRadius: 15,
    title: title,
    message: message,
    backgroundColor: const  Color(0xff043040),
    icon: const Icon(Icons.notifications_active, color: Colors.white),
    duration: const Duration(seconds: 3),
    dismissDirection: DismissDirection.horizontal,
  );

}