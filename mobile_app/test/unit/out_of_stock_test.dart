import 'package:flutter_test/flutter_test.dart';
import 'package:qr_menu/models/menu_item.dart';
import 'package:qr_menu/services/menu_service.dart';

/// RED 단계: 실패하는 테스트 작성
/// 
/// Scenario: 품절 메뉴는 노출되지 않는다
/// Given 메뉴가 품절 상태일 때
/// When 고객이 메뉴판을 조회하면
/// Then 해당 메뉴는 비활성화되거나 숨김 처리되어야 한다
void main() {
  group('OutOfStock - 품절 메뉴 처리 테스트', () {
    test('품절 메뉴는 비활성화되거나 숨김 처리되어야 한다', () async {
      // Given: 품절 상태인 메뉴
      // TODO: MenuService 구현 필요
      // MenuService menuService = MenuServiceImpl();
      
      // When: 메뉴판 조회
      // final menus = await menuService.getAvailableMenus();
      
      // Then: 품절 메뉴 숨김/비활성화 확인
      // expect(menus.every((menu) => menu.isAvailable), isTrue);
      // expect(menus.any((menu) => !menu.isAvailable), isFalse);
      
      // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
      fail('품절 메뉴 필터링 기능이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
    });
  });
}

