import 'package:flutter/material.dart';

/// 반응형 디자인 유틸리티
/// 
/// 화면 크기에 따른 레이아웃 조정

/// 화면 크기 브레이크포인트
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

/// 반응형 유틸리티 클래스
class ResponsiveUtils {
  /// 현재 화면 너비 가져오기
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 현재 화면 높이 가져오기
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 모바일 화면인지 확인
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < Breakpoints.mobile;
  }

  /// 태블릿 화면인지 확인
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= Breakpoints.mobile && width < Breakpoints.desktop;
  }

  /// 데스크톱 화면인지 확인
  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= Breakpoints.desktop;
  }

  /// 화면 크기에 따른 컬럼 수 반환
  static int getColumnCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  /// 화면 크기에 따른 패딩 반환
  static double getPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 32.0;
  }

  /// 화면 크기에 따른 최대 너비 반환
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800.0;
    return 1200.0;
  }
}


