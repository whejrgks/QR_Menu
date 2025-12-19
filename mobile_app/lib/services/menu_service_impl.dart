import '../models/menu_item.dart';
import 'menu_service.dart';
import '../data/menu_mock_data.dart';

/// MenuService 인터페이스 구현체
/// 
/// 메모리 기반으로 메뉴 정보를 관리하는 구현체입니다.
/// 초기 데이터는 Mock 데이터를 사용하며, 런타임 중 변경사항은 메모리에 저장됩니다.
/// 
/// **현재 상태:**
/// - 메모리 기반 메뉴 관리
/// - 초기값은 Mock 데이터 사용
/// - 향후 실제 API나 Database 연동으로 교체 가능합니다.
/// 
/// **사용 예시:**
/// ```dart
/// final menuService = MenuServiceImpl();
/// final menus = await menuService.getAvailableMenus();
/// ```
class MenuServiceImpl implements MenuService {
  // 메모리 기반 메뉴 저장소
  static List<MenuItem> _menus = [];

  // 초기화 여부 확인
  static bool _initialized = false;

  /// 초기 데이터 로드 (Mock 데이터 사용)
  void _initializeIfNeeded() {
    if (!_initialized) {
      _menus = List.from(MenuMockData.getMenusWithOutOfStock());
      _initialized = true;
    }
  }

  MenuServiceImpl() {
    _initializeIfNeeded();
  }

  @override
  Future<List<MenuItem>> getAvailableMenus() async {
    _initializeIfNeeded();
    // 품절 메뉴 필터링 (isAvailable == true인 메뉴만)
    return _menus.where((menu) => menu.isAvailable).toList();
  }

  @override
  Future<MenuItem?> getMenuById(String id) async {
    _initializeIfNeeded();
    try {
      return _menus.firstWhere((menu) => menu.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<MenuItem>> getAllMenus() async {
    _initializeIfNeeded();
    return List.from(_menus);
  }

  @override
  Future<MenuItem?> updateMenuAvailability(String menuId, bool isAvailable) async {
    _initializeIfNeeded();
    final index = _menus.indexWhere((menu) => menu.id == menuId);
    if (index == -1) {
      return null;
    }

    final menu = _menus[index];
    final updatedMenu = MenuItem(
      id: menu.id,
      name: menu.name,
      description: menu.description,
      price: menu.price,
      imageUrl: menu.imageUrl,
      allergens: menu.allergens,
      isAvailable: isAvailable,
    );
    _menus[index] = updatedMenu;
    return updatedMenu;
  }

  @override
  Future<MenuItem> addMenu(MenuItem menu) async {
    _initializeIfNeeded();
    _menus.add(menu);
    return menu;
  }

  @override
  Future<MenuItem?> updateMenu(MenuItem menu) async {
    _initializeIfNeeded();
    final index = _menus.indexWhere((m) => m.id == menu.id);
    if (index == -1) {
      return null;
    }
    _menus[index] = menu;
    return menu;
  }

  @override
  Future<bool> deleteMenu(String menuId) async {
    _initializeIfNeeded();
    final index = _menus.indexWhere((menu) => menu.id == menuId);
    if (index == -1) {
      return false;
    }
    _menus.removeAt(index);
    return true;
  }
}

