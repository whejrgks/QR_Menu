import 'package:flutter_test/flutter_test.dart';
import 'package:qr_menu/models/menu_item.dart';
import 'package:qr_menu/services/menu_service.dart';
import 'package:qr_menu/services/menu_service_impl.dart';

/// GREEN 단계: 테스트 통과 확인
/// 
/// Scenario: 고객이 QR 코드로 메뉴를 조회한다
/// Given 고객이 QR 코드를 스캔했을 때
/// When 메뉴 화면이 로드되면
/// Then 판매 중인 메뉴 목록이 표시되어야 한다

void main() {
  group('MenuService - 메뉴 조회 테스트', () {
    test('고객이 QR 코드를 스캔하면 판매 중인 메뉴 목록이 표시되어야 한다', () async {
      // Given: QR 코드 스캔 시나리오
      MenuService menuService = MenuServiceImpl();
      
      // When: 메뉴 화면 로드
      final menus = await menuService.getAvailableMenus();
      
      // Then: 판매 중인 메뉴 목록 표시 확인
      expect(menus, isNotEmpty);
      expect(menus.every((menu) => menu.isAvailable), isTrue);
    });
  });
}

