/// 포맷팅 유틸리티
/// 
/// 앱 전역에서 사용하는 포맷팅 함수들

/// 가격을 원 단위로 포맷팅
/// 
/// 예: 12000 -> "12,000원"
String formatPrice(double price) {
  return '${price.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  )}원';
}

/// 가격을 원 단위로 포맷팅 (간단한 버전)
/// 
/// 예: 12000 -> "12000원"
String formatPriceSimple(double price) {
  return '${price.toStringAsFixed(0)}원';
}


