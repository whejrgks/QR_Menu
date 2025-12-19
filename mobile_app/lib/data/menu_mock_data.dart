import '../models/menu_item.dart';

/// Mock 데이터 및 테스트 더미
class MenuMockData {
  /// 판매 중인 메뉴 목록 Mock 데이터
  static List<MenuItem> getAvailableMenus() {
    return [
      MenuItem(
        id: 'menu-001',
        name: '불고기 버거',
        description: '신선한 불고기 패티와 야채가 들어간 버거',
        price: 12000,
        imageUrl: 'https://example.com/burger.jpg',
        allergens: ['밀', '우유', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-002',
        name: '치즈 버거',
        description: '두툼한 치즈가 들어간 클래식 버거',
        price: 11000,
        imageUrl: 'https://example.com/cheese_burger.jpg',
        allergens: ['밀', '우유', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-003',
        name: '치킨 버거',
        description: '바삭한 치킨 패티가 들어간 버거',
        price: 13000,
        imageUrl: 'https://example.com/chicken_burger.jpg',
        allergens: ['밀', '우유'],
        isAvailable: true,
      ),
    ];
  }

  /// 품절 메뉴 포함 Mock 데이터
  static List<MenuItem> getMenusWithOutOfStock() {
    return [
      MenuItem(
        id: 'menu-001',
        name: '불고기 버거',
        description: '신선한 불고기 패티와 야채가 들어간 버거',
        price: 12000,
        imageUrl: 'https://example.com/burger.jpg',
        allergens: ['밀', '우유', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-002',
        name: '치즈 버거',
        description: '두툼한 치즈가 들어간 클래식 버거',
        price: 11000,
        imageUrl: 'https://example.com/cheese_burger.jpg',
        allergens: ['밀', '우유', '대두'],
        isAvailable: false, // 품절
      ),
      MenuItem(
        id: 'menu-003',
        name: '치킨 버거',
        description: '바삭한 치킨 패티가 들어간 버거',
        price: 13000,
        imageUrl: 'https://example.com/chicken_burger.jpg',
        allergens: ['밀', '우유'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-004',
        name: '베이컨 더블 버거',
        description: '두 장의 패티와 바삭한 베이컨이 들어간 프리미엄 버거',
        price: 15000,
        imageUrl: 'https://example.com/bacon_double_burger.jpg',
        allergens: ['밀', '우유', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-005',
        name: '새우 버거',
        description: '통통한 새우 패티와 특제 타르타르 소스',
        price: 14000,
        imageUrl: 'https://example.com/shrimp_burger.jpg',
        allergens: ['밀', '갑각류'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-006',
        name: '비프 스테이크',
        description: '부드러운 소고기 스테이크와 감자튀김',
        price: 25000,
        imageUrl: 'https://example.com/beef_steak.jpg',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-007',
        name: '치킨 텐더',
        description: '바삭하게 튀긴 치킨 텐더 6조각',
        price: 12000,
        imageUrl: 'https://example.com/chicken_tender.jpg',
        allergens: ['밀', '우유'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-008',
        name: '감자튀김',
        description: '바삭한 감자튀김 (대)',
        price: 5000,
        imageUrl: 'https://example.com/french_fries.jpg',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-009',
        name: '콜라',
        description: '시원한 콜라 (500ml)',
        price: 3000,
        imageUrl: 'https://example.com/cola.jpg',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-010',
        name: '사이다',
        description: '시원한 사이다 (500ml)',
        price: 3000,
        imageUrl: 'https://example.com/sprite.jpg',
        allergens: null,
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-011',
        name: '양념 치킨',
        description: '달콤한 양념이 발린 치킨',
        price: 18000,
        imageUrl: 'https://example.com/seasoned_chicken.jpg',
        allergens: ['밀', '대두'],
        isAvailable: true,
      ),
      MenuItem(
        id: 'menu-012',
        name: '피자',
        description: '치즈가 가득한 페퍼로니 피자',
        price: 20000,
        imageUrl: 'https://example.com/pizza.jpg',
        allergens: ['밀', '우유'],
        isAvailable: false, // 품절
      ),
      MenuItem(
        id: 'menu-013',
        name: '파스타',
        description: '크림 소스 파스타',
        price: 15000,
        imageUrl: 'https://example.com/pasta.jpg',
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

