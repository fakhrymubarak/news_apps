import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';

// Blue text
void logInfo(String msg) {
  dev.log('\x1B[34m$msg\x1B[0m');
}

// Green text
void logSuccess(String msg) {
  dev.log('\x1B[32m$msg\x1B[0m');
}

// Yellow text
void logWarning(String msg) {
  dev.log('\x1B[33m$msg\x1B[0m');
}

// Red text
void logError(String msg, [StackTrace? trace]) {
  dev.log('\x1B[31m$msg\x1B[0m');

  if (trace != null) {
    debugPrintStack(stackTrace: trace);
  }
}
