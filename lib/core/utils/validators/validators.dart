import 'package:flutter/material.dart';

abstract class Valdiator {
  static FormFieldValidator<String?> emailValidator = (value) {
    if (value == null || value.trim().isEmpty) {
      return "Email Is Required";
    }
    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(value)) {
      return "Email Is Not Valid";
    }
    return null;
  };
  static FormFieldValidator<String?> nameValidator = (value) {
    if (value == null || value.trim().isEmpty) {
      return "Name Is Required";
    }
    if (value.length > 20) {
      return "Name Is Too Long";
    }
    return null;
  };
  static FormFieldValidator<String?> passValidator = (value) {
    if (value == null || value.trim().isEmpty) {
      return "Password Is Required";
    }
    if (value.length < 6) {
      return "Password Is Too Short";
    }
    return null;
  };
}