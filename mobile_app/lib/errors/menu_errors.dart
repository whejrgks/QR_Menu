/// 메뉴 관련 에러 타입 정의
/// 
/// 다양한 에러 상황을 명확히 구분하여 사용자에게 적절한 메시지를 제공합니다.

/// 메뉴 에러 기본 클래스
abstract class MenuError implements Exception {
  final String message;
  final String? details;

  MenuError(this.message, [this.details]);

  @override
  String toString() => message;
}

/// 네트워크 에러
/// 인터넷 연결 문제나 서버 통신 실패 시 발생
class NetworkError extends MenuError {
  NetworkError([String? details])
      : super('인터넷 연결을 확인해주세요.', details);

  @override
  String toString() => 'NetworkError: $message';
}

/// 데이터 로딩 에러
/// 메뉴 데이터를 불러오는 중 문제가 발생한 경우
class DataLoadingError extends MenuError {
  DataLoadingError([String? details])
      : super('메뉴를 불러올 수 없습니다.', details);

  @override
  String toString() => 'DataLoadingError: $message';
}

/// 메뉴를 찾을 수 없는 에러
/// 요청한 메뉴 ID가 존재하지 않는 경우
class MenuNotFoundError extends MenuError {
  final String menuId;

  MenuNotFoundError(this.menuId, [String? details])
      : super('메뉴를 찾을 수 없습니다.', details);

  @override
  String toString() => 'MenuNotFoundError: $message (menuId: $menuId)';
}

/// 알 수 없는 에러
/// 예상치 못한 에러가 발생한 경우
class UnknownError extends MenuError {
  UnknownError([String? details])
      : super('알 수 없는 오류가 발생했습니다.', details);

  @override
  String toString() => 'UnknownError: $message';
}


