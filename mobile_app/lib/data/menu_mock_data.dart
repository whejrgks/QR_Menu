import '../models/menu_item.dart';

/// Mock 데이터 및 테스트 더미
class MenuMockData {
  /// 판매 중인 메뉴 목록 Mock 데이터
  static List<MenuItem> getAvailableMenus() {
    // getMenusWithOutOfStock()에서 품절 메뉴를 제외한 목록 반환
    return getMenusWithOutOfStock()
        .where((menu) => menu.isAvailable)
        .toList();
  }

  /// 품절 메뉴 포함 Mock 데이터
  static List<MenuItem> getMenusWithOutOfStock() {
    return [
      MenuItem(
        id: 'menu-001',
        name: '불고기 버거',
        description: '신선한 불고기 패티와 야채가 들어간 버거',
        price: 12000,
        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400&h=300&fit=crop',
        allergens: ['밀', '우유', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-002',
        name: '치즈 버거',
        description: '두툼한 치즈가 들어간 클래식 버거',
        price: 11000,
        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400&h=300&fit=crop',
        allergens: ['밀', '우유', '대두'],
        isAvailable: false, // 품절
      ),
      MenuItem(
        id: 'menu-003',
        name: '치킨 버거',
        description: '바삭한 치킨 패티가 들어간 버거',
        price: 13000,
        imageUrl: 'https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=400&h=300&fit=crop',
        allergens: ['밀', '우유'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-004',
        name: '베이컨 더블 버거',
        description: '두 장의 패티와 바삭한 베이컨이 들어간 프리미엄 버거',
        price: 15000,
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop&q=80&auto=format',
        allergens: ['밀', '우유', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-005',
        name: '새우 버거',
        description: '통통한 새우 패티와 특제 타르타르 소스',
        price: 14000,
        imageUrl: 'https://images.unsplash.com/photo-1528607929212-4d8c0e1e4b0a?w=400&h=300&fit=crop&q=80&auto=format',
        allergens: ['밀', '갑각류'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-006',
        name: '비프 스테이크',
        description: '부드러운 소고기 스테이크와 감자튀김',
        price: 25000,
        imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400&h=300&fit=crop',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-007',
        name: '치킨 텐더',
        description: '바삭하게 튀긴 치킨 텐더 6조각',
        price: 12000,
        imageUrl: 'https://images.unsplash.com/photo-1626087927381-6c0a04f0a65b?w=400&h=300&fit=crop&q=80&auto=format',
        allergens: ['밀', '우유'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-008',
        name: '감자튀김',
        description: '바삭한 감자튀김 (대)',
        price: 5000,
        imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-009',
        name: '콜라',
        description: '시원한 콜라 (500ml)',
        price: 3000,
        imageUrl: 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-010',
        name: '사이다',
        description: '시원한 사이다 (500ml)',
        price: 3000,
        imageUrl: 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-011',
        name: '양념 치킨',
        description: '달콤한 양념이 발린 치킨',
        price: 18000,
        imageUrl: 'https://images.unsplash.com/photo-1626645738192-c2a33f5b4efb?w=400&h=300&fit=crop&q=80&auto=format',
        allergens: ['밀', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-012',
        name: '피자',
        description: '치즈가 가득한 페퍼로니 피자',
        price: 20000,
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
        allergens: ['밀', '우유'],
        isAvailable: false, // 품절
      ),
      MenuItem(
        id: 'menu-013',
        name: '파스타',
        description: '크림 소스 파스타',
        price: 15000,
        imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=400&h=300&fit=crop',
        allergens: ['밀', '우유'],
        isAvailable: true,
      ),
    ];
  }

  /// 특정 메뉴 Mock 데이터
  static MenuItem getMenuById(String id) {
    return getAvailableMenus().firstWhere(
      (menu) => menu.id == id,
      orElse: () => throw Exception('Menu not found: $id'),
    );
  }
}

