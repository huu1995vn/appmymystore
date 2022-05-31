import 'package:flutter/material.dart';

extension FlavourTypeExtension on String {
  Color getFlavourColor() {
    switch (this) {
      case 'dev':
        return Colors.yellow[800]!;     
      case 'prod':
        return Colors.green[600]!;
      default:
        return Colors.blue[600]!;
    }
  }

  String getFlavourName() {
    switch (this) {
      case 'dev':
        return 'Development';
      case 'prod':
        return 'Production';
      default:
        return 'Unknown';
    }
  }
}