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

