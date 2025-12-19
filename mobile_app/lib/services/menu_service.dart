import '../models/menu_item.dart';

/// 메뉴 서비스 인터페이스
/// 
/// 메뉴 데이터를 조회하는 서비스의 추상 인터페이스입니다.
/// 이 인터페이스를 구현하여 다양한 데이터 소스(Mock, API, Database 등)에서
/// 메뉴 데이터를 가져올 수 있습니다.
/// 
/// **구현 클래스:**
/// - [MenuServiceImpl]: Mock 데이터를 사용하는 구현체
/// 
/// **사용 예시:**
/// ```dart
/// final menuService = MenuServiceImpl();
/// final menus = await menuService.getAvailableMenus();
/// ```
abstract class MenuService {
  /// 판매 가능한 메뉴 목록을 가져옵니다.
  /// 
  /// 품절 메뉴(`isAvailable == false`)는 제외하고 반환합니다.
  /// 
  /// **반환값:**
  /// - [List<MenuItem>]: 판매 가능한 메뉴 목록
  /// 
  /// **예외:**
  /// - 네트워크 오류나 데이터 로딩 실패 시 예외가 발생할 수 있습니다.
  Future<List<MenuItem>> getAvailableMenus();

  /// 특정 ID의 메뉴 상세 정보를 가져옵니다.
  /// 
  /// **매개변수:**
  /// - [id]: 조회할 메뉴의 고유 ID
  /// 
  /// **반환값:**
  /// - [MenuItem?]: 메뉴 정보 (존재하지 않는 경우 null)
  /// 
  /// **예외:**
  /// - 네트워크 오류나 데이터 로딩 실패 시 예외가 발생할 수 있습니다.
  Future<MenuItem?> getMenuById(String id);

  /// 모든 메뉴 목록을 가져옵니다 (품절 포함).
  /// 
  /// 관리자 화면에서 사용하며, 품절 메뉴도 포함하여 반환합니다.
  /// 
  /// **반환값:**
  /// - [List<MenuItem>]: 모든 메뉴 목록 (품절 포함)
  /// 
  /// **예외:**
  /// - 네트워크 오류나 데이터 로딩 실패 시 예외가 발생할 수 있습니다.
  Future<List<MenuItem>> getAllMenus();

  /// 메뉴의 품절 상태를 업데이트합니다.
  /// 
  /// **매개변수:**
  /// - [menuId]: 업데이트할 메뉴의 고유 ID
  /// - [isAvailable]: 새로운 품절 상태 (true: 판매 중, false: 품절)
  /// 
  /// **반환값:**
  /// - [MenuItem?]: 업데이트된 메뉴 정보 (존재하지 않는 경우 null)
  Future<MenuItem?> updateMenuAvailability(String menuId, bool isAvailable);

  /// 새 메뉴를 추가합니다.
  /// 
  /// **매개변수:**
  /// - [menu]: 추가할 메뉴 정보
  /// 
  /// **반환값:**
  /// - [MenuItem]: 추가된 메뉴 정보
  Future<MenuItem> addMenu(MenuItem menu);

  /// 메뉴 정보를 업데이트합니다.
  /// 
  /// **매개변수:**
  /// - [menu]: 업데이트할 메뉴 정보
  /// 
  /// **반환값:**
  /// - [MenuItem?]: 업데이트된 메뉴 정보 (존재하지 않는 경우 null)
  Future<MenuItem?> updateMenu(MenuItem menu);

  /// 메뉴를 삭제합니다.
  /// 
  /// **매개변수:**
  /// - [menuId]: 삭제할 메뉴의 고유 ID
  /// 
  /// **반환값:**
  /// - [bool]: 삭제 성공 여부
  Future<bool> deleteMenu(String menuId);
}

