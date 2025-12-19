import '../models/menu_item.dart';

/// 메뉴 서비스 인터페이스
abstract class MenuService {
  Future<List<MenuItem>> getAvailableMenus();
  Future<MenuItem?> getMenuById(String id);
}

