# 🟢 GREEN 단계: UI 위젯 구현 시나리오

## 📋 구현 목표

**목표:** 테스트를 통과시키는 최소한의 UI 위젯 구현

**대상 파일:**
- `lib/screens/menu_list_screen.dart` (신규 생성)
- `lib/screens/menu_detail_screen.dart` (신규 생성)

---

## 🎯 구현 시나리오

### 시나리오 1: MenuListScreen 구현

**목표:** 메뉴 목록 화면 위젯 구현

**테스트 요구사항:**
- `menu_list_screen_test.dart`:
  - `MenuListScreen()` 위젯이 존재해야 함
  - `find.text('메뉴 목록')` - '메뉴 목록' 텍스트 표시
  - `find.byType(ListView)` - ListView 위젯 존재
  - `pumpAndSettle()` - 화면이 정상적으로 로드됨

**구현 내용:**
```dart
import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';

class MenuListScreen extends StatelessWidget {
  final MenuService menuService = MenuServiceImpl();

  MenuListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 목록'),
      ),
      body: FutureBuilder<List<MenuItem>>(
        future: menuService.getAvailableMenus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('메뉴를 불러올 수 없습니다.'));
          }

          final menus = snapshot.data!;
          
          return ListView.builder(
            itemCount: menus.length,
            itemBuilder: (context, index) {
              final menu = menus[index];
              return ListTile(
                title: Text(menu.name),
                subtitle: Text('${menu.price.toStringAsFixed(0)}원'),
              );
            },
          );
        },
      ),
    );
  }
}
```

**검증:**
- ✅ '메뉴 목록' 텍스트 표시 (AppBar title)
- ✅ ListView 위젯 존재
- ✅ MenuService와 연동하여 메뉴 데이터 로드
- ✅ 테스트 통과

**예상 결과:**
- `menu_list_screen_test.dart` ✅ 통과

---

### 시나리오 2: MenuDetailScreen 구현

**목표:** 메뉴 상세 화면 위젯 구현

**테스트 요구사항:**
- `menu_detail_screen_test.dart`:
  - `MenuDetailScreen(menuId: menuId)` - menuId 파라미터 필요
  - `find.byType(Image)` - Image 위젯 표시
  - `find.textContaining('원')` - 가격 텍스트 표시 (원 단위)
  - `find.byType(Text)` - Text 위젯 여러 개
  - `find.text('알레르기 정보')` - 알레르기 정보 텍스트 표시

**구현 내용:**
```dart
import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';

class MenuDetailScreen extends StatelessWidget {
  final String menuId;
  final MenuService menuService = MenuServiceImpl();

  const MenuDetailScreen({
    Key? key,
    required this.menuId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 상세'),
      ),
      body: FutureBuilder<MenuItem?>(
        future: menuService.getMenuById(menuId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('메뉴를 찾을 수 없습니다.'));
          }

          final menu = snapshot.data!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 표시
                if (menu.imageUrl != null)
                  Image.network(
                    menu.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                
                const SizedBox(height: 16),
                
                // 가격 표시 (원 단위)
                Text(
                  '${menu.price.toStringAsFixed(0)}원',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                
                const SizedBox(height: 8),
                
                // 설명 표시
                Text(
                  menu.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                
                const SizedBox(height: 16),
                
                // 알레르기 정보 표시
                const Text(
                  '알레르기 정보',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                
                if (menu.allergens != null && menu.allergens!.isNotEmpty)
                  ...menu.allergens!.map((allergen) => Text(allergen)),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

**검증:**
- ✅ Image 위젯 표시 (imageUrl이 있을 때)
- ✅ 가격 텍스트 표시 (원 단위 포함)
- ✅ 설명 텍스트 표시
- ✅ '알레르기 정보' 텍스트 표시
- ✅ MenuService와 연동하여 메뉴 데이터 로드
- ✅ 테스트 통과

**예상 결과:**
- `menu_detail_screen_test.dart` ✅ 통과

---

## 📝 구현 단계별 계획

### Step 1: MenuListScreen 구현
1. `lib/screens/menu_list_screen.dart` 파일 생성
2. 필요한 import 문 추가
3. MenuListScreen 클래스 구현
4. MenuService 연동
5. ListView 구현
6. '메뉴 목록' 텍스트 표시

### Step 2: MenuDetailScreen 구현
1. `lib/screens/menu_detail_screen.dart` 파일 생성
2. 필요한 import 문 추가
3. MenuDetailScreen 클래스 구현 (menuId 파라미터)
4. MenuService 연동
5. Image, 가격, 설명, 알레르기 정보 표시

### Step 3: 테스트 파일 수정
1. `menu_list_screen_test.dart` - 주석 해제 및 fail() 제거
2. `menu_detail_screen_test.dart` - 주석 해제 및 fail() 제거
3. 실제 테스트 로직 활성화

### Step 4: 테스트 실행 및 검증
1. `flutter test test/widget/` 실행
2. 모든 테스트 통과 확인
3. 커버리지 측정

---

## 🔍 테스트 파일 수정 계획

### menu_list_screen_test.dart 수정

**변경 전:**
```dart
testWidgets('메뉴 화면이 로드되면 판매 중인 메뉴 목록이 표시되어야 한다', (WidgetTester tester) async {
  // Given: QR 코드 스캔 시나리오
  // TODO: MenuListScreen 위젯 구현 필요
  // await tester.pumpWidget(
  //   MaterialApp(
  //     home: MenuListScreen(),
  //   ),
  // );
  
  // When: 메뉴 화면 로드
  // await tester.pumpAndSettle();
  
  // Then: 판매 중인 메뉴 목록 표시 확인
  // expect(find.text('메뉴 목록'), findsOneWidget);
  // expect(find.byType(ListView), findsOneWidget);
  
  // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
  fail('MenuListScreen 위젯이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
});
```

**변경 후:**
```dart
import 'package:qr_menu/screens/menu_list_screen.dart';

testWidgets('메뉴 화면이 로드되면 판매 중인 메뉴 목록이 표시되어야 한다', (WidgetTester tester) async {
  // Given: QR 코드 스캔 시나리오
  await tester.pumpWidget(
    const MaterialApp(
      home: MenuListScreen(),
    ),
  );
  
  // When: 메뉴 화면 로드
  await tester.pumpAndSettle();
  
  // Then: 판매 중인 메뉴 목록 표시 확인
  expect(find.text('메뉴 목록'), findsOneWidget);
  expect(find.byType(ListView), findsOneWidget);
});
```

---

### menu_detail_screen_test.dart 수정

**변경 전:**
```dart
testWidgets('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다', (WidgetTester tester) async {
  // Given: 메뉴 목록 화면
  // TODO: MenuDetailScreen 위젯 구현 필요
  // const menuId = 'menu-001';
  // await tester.pumpWidget(
  //   MaterialApp(
  //     home: MenuDetailScreen(menuId: menuId),
  //   ),
  // );
  
  // When: 특정 메뉴 선택
  // await tester.pumpAndSettle();
  
  // Then: 상세 정보 표시 확인
  // expect(find.byType(Image), findsOneWidget);
  // expect(find.textContaining('원'), findsOneWidget);
  // expect(find.byType(Text), findsWidgets);
  // expect(find.text('알레르기 정보'), findsOneWidget);
  
  // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
  fail('MenuDetailScreen 위젯이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
});
```

**변경 후:**
```dart
import 'package:qr_menu/screens/menu_detail_screen.dart';

testWidgets('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다', (WidgetTester tester) async {
  // Given: 메뉴 목록 화면
  const menuId = 'menu-001';
  await tester.pumpWidget(
    const MaterialApp(
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
```

---

## ✅ 구현 완료 검증 기준

### 기능 검증
- [ ] `MenuListScreen` 위젯이 정상적으로 렌더링됨
- [ ] `MenuDetailScreen` 위젯이 정상적으로 렌더링됨
- [ ] MenuService와 올바르게 연동됨
- [ ] 메뉴 데이터가 정상적으로 표시됨

### 테스트 검증
- [ ] `menu_list_screen_test.dart` 통과
- [ ] `menu_detail_screen_test.dart` 통과
- [ ] 모든 위젯 테스트가 성공적으로 실행됨

### 코드 품질
- [ ] 최소한의 코드로 테스트 통과 (GREEN 단계 원칙 준수)
- [ ] 코드가 읽기 쉽고 이해하기 쉬움
- [ ] 주석이 적절히 포함됨
- [ ] 에러 처리 포함 (FutureBuilder 사용)

---

## 📊 예상 결과

### 테스트 실행 결과
```
00:03 +5 -0: All tests passed!

Passed tests:
  1. menu_service_test.dart ✅
  2. menu_detail_test.dart ✅
  3. out_of_stock_test.dart ✅
  4. menu_list_screen_test.dart ✅
  5. menu_detail_screen_test.dart ✅

Summary: 5 passed, 0 failed
```

### 커버리지 예상
- **UI 위젯 구현:** +20% 커버리지 증가
- **전체 커버리지:** 95%+ (구현된 코드 기준)

---

## 🎯 최소 단위 구현 원칙

1. **테스트 통과 우선**: 테스트를 통과시키는 최소한의 코드만 작성
2. **FutureBuilder 사용**: 비동기 데이터 로딩 처리
3. **에러 처리**: 기본적인 에러 처리 포함
4. **복잡도 최소화**: 최적화나 복잡한 로직은 REFACTOR 단계에서 수행
5. **위젯 구조 단순화**: StatelessWidget 사용 (상태 관리 없이)

---

## 📝 참고사항

- MenuService는 이미 구현되어 있음 (`MenuServiceImpl`)
- Mock 데이터는 `lib/data/menu_mock_data.dart`에 준비되어 있음
- 테스트는 비동기 처리를 위해 `pumpAndSettle()` 사용
- 향후 실제 API 연동 시에도 위젯 구조는 동일하게 유지

---

## 🔄 향후 개선 사항 (REFACTOR 단계)

- 상태 관리 라이브러리 도입 (Riverpod/Provider)
- 로딩 상태 개선
- 에러 처리 개선
- 이미지 캐싱
- UI/UX 개선

---

**작성일:** 2025-12-19  
**상태:** ⏳ 승인 대기  
**다음 단계:** 승인 후 구현 진행

