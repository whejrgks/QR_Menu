import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_menu/screens/menu_detail_screen.dart';

/// GREEN 단계: 테스트 통과 확인
/// 
/// Scenario: 고객이 메뉴 상세 정보를 확인한다
/// Given 고객이 메뉴 목록을 보고 있을 때
/// When 특정 메뉴를 선택하면
/// Then 메뉴 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
void main() {
  group('MenuDetailScreen - 메뉴 상세 화면 테스트', () {
    testWidgets('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다', (WidgetTester tester) async {
      // Given: 메뉴 목록 화면
      const menuId = 'menu-001';
      await tester.pumpWidget(
        MaterialApp(
          home: MenuDetailScreen(menuId: menuId),
        ),
      );
      
      // When: 특정 메뉴 선택
      await tester.pumpAndSettle();
      
      // Then: 상세 정보 표시 확인
      expect(find.byType(Image), findsOneWidget);
      expect(find.textContaining('원'), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
      expect(find.text('알레르기 정보'), findsOneWidget);
    });
  });
}

