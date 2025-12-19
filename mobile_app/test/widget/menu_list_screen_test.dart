import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_menu/screens/menu_list_screen.dart';

/// GREEN 단계: 테스트 통과 확인
/// 
/// Scenario: 고객이 QR 코드로 메뉴를 조회한다
/// Given 고객이 QR 코드를 스캔했을 때
/// When 메뉴 화면이 로드되면
/// Then 판매 중인 메뉴 목록이 표시되어야 한다
void main() {
  group('MenuListScreen - 메뉴 목록 화면 테스트', () {
    testWidgets('메뉴 화면이 로드되면 판매 중인 메뉴 목록이 표시되어야 한다', (WidgetTester tester) async {
      // Given: QR 코드 스캔 시나리오
      await tester.pumpWidget(
        MaterialApp(
          home: MenuListScreen(),
        ),
      );
      
      // When: 메뉴 화면 로드
      await tester.pumpAndSettle();
      
      // Then: 판매 중인 메뉴 목록 표시 확인
      expect(find.text('메뉴 목록'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}

