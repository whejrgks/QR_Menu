import '../models/menu_item.dart';

/// 메뉴 서비스 인터페이스
abstract class MenuService {
  Future<List<MenuItem>> getAvailableMenus();
  Future<MenuItem?> getMenuById(String id);
  /// 모든 메뉴 목록 가져오기 (품절 포함) - 관리자용
  Future<List<MenuItem>> getAllMenus();
}

