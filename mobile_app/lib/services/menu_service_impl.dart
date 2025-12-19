import '../models/menu_item.dart';
import 'menu_service.dart';
import '../data/menu_mock_data.dart';

/// MenuService 인터페이스 구현체
class MenuServiceImpl implements MenuService {
  @override
  Future<List<MenuItem>> getAvailableMenus() async {
    // 1. Mock 데이터에서 모든 메뉴 가져오기 (품절 메뉴 포함)
    final allMenus = MenuMockData.getMenusWithOutOfStock();
    
    // 2. 품절 메뉴 필터링 (isAvailable == true인 메뉴만)
    final availableMenus = allMenus.where((menu) => menu.isAvailable).toList();
    
    // 3. Future로 반환 (비동기 처리)
    return Future.value(availableMenus);
  }

  @override
  Future<MenuItem?> getMenuById(String id) async {
    // 1. Mock 데이터에서 모든 메뉴 가져오기
    final allMenus = MenuMockData.getAvailableMenus();
    
    // 2. ID로 메뉴 검색
    try {
      final menu = allMenus.firstWhere((menu) => menu.id == id);
      return Future.value(menu);
    } catch (e) {
      // 3. 존재하지 않는 ID인 경우 null 반환
      return Future.value(null);
    }
  }

  @override
  Future<List<MenuItem>> getAllMenus() async {
    // 모든 메뉴 가져오기 (품절 포함) - 관리자용
    return Future.value(MenuMockData.getMenusWithOutOfStock());
  }
}

