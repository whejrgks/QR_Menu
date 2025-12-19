import 'package:flutter/material.dart';

/// 앱 전역 상수
/// 
/// 앱 전체에서 사용하는 상수 값들

/// 앱 정보
class AppInfo {
  static const String appName = 'QR 메뉴판';
  static const String appVersion = '1.0.0';
}

/// 색상 상수
class AppColors {
  static const Color primary = Colors.blue;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color success = Colors.green;
  static const Color grey = Colors.grey;
}

/// 패딩 상수
class AppPadding {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;
}

/// 아이콘 크기 상수
class AppIconSize {
  static const double small = 24.0;
  static const double medium = 32.0;
  static const double large = 48.0;
  static const double xLarge = 64.0;
}

/// 이미지 크기 상수
class AppImageSize {
  static const double menuDetailHeight = 200.0;
  static const double menuCardHeight = 120.0;
}

/// 타이밍 상수
class AppTiming {
  static const Duration shortDelay = Duration(milliseconds: 300);
  static const Duration mediumDelay = Duration(milliseconds: 500);
  static const Duration longDelay = Duration(seconds: 1);
  static const Duration snackBarDuration = Duration(seconds: 2);
}

/// 관리자 관련 상수
class AdminConstants {
  static const String defaultPassword = 'admin123';
  static const String passwordHint = '※ 테스트용 비밀번호: admin123';
}

