import 'package:flutter_test/flutter_test.dart';
import 'package:qr_menu/models/menu_item.dart';
import 'package:qr_menu/services/menu_service.dart';

/// RED 단계: 실패하는 테스트 작성
/// 
/// Scenario: 고객이 메뉴 상세 정보를 확인한다
/// Given 고객이 메뉴 목록을 보고 있을 때
/// When 특정 메뉴를 선택하면
/// Then 메뉴 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
void main() {
  group('MenuDetail - 메뉴 상세 정보 테스트', () {
    test('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다', () async {
      // Given: 메뉴 목록 화면
      // TODO: MenuService 구현 필요
      // MenuService menuService = MenuServiceImpl();
      const menuId = 'menu-001';
      
      // When: 특정 메뉴 선택
      // final menu = await menuService.getMenuById(menuId);
      
      // Then: 상세 정보 표시 확인
      // expect(menu, isNotNull);
      // expect(menu!.imageUrl, isNotNull);
      // expect(menu.price, greaterThan(0));
      // expect(menu.description, isNotEmpty);
      // expect(menu.allergens, isNotNull);
      
      // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
      fail('MenuService.getMenuById가 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
    });
  });
}

