import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';

/// MenuService Provider
/// 
/// MenuService 인스턴스를 제공하는 Provider입니다.
/// 싱글톤 패턴으로 동일한 인스턴스를 반환하여 데이터 일관성을 보장합니다.
/// 
/// **사용 예시:**
/// ```dart
/// final menuService = ref.watch(menuServiceProvider);
/// final menus = await menuService.getAvailableMenus();
/// ```
final menuServiceProvider = Provider<MenuService>((ref) {
  // 싱글톤 패턴: 동일한 인스턴스를 반환하여 데이터 일관성 보장
  ref.keepAlive();
  return MenuServiceImpl();
});

/// 메뉴 목록 Provider
/// 
/// 판매 가능한 메뉴 목록을 제공하는 FutureProvider입니다.
/// 품절 메뉴는 자동으로 필터링되어 반환됩니다.
/// 
/// **성능 최적화:**
/// - `keepAlive`를 통해 데이터 캐싱 및 불필요한 재로딩 방지
/// 
/// **사용 예시:**
/// ```dart
/// final menuListAsync = ref.watch(menuListProvider);
/// menuListAsync.when(
///   data: (menus) => ListView.builder(...),
///   loading: () => CircularProgressIndicator(),
///   error: (error, stack) => ErrorWidget(),
/// );
/// ```
final menuListProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuService = ref.watch(menuServiceProvider);
  final menus = await menuService.getAvailableMenus();
  
  // keepAlive 제거: 변경사항이 즉시 반영되도록 함
  // 필요시 자동으로 다시 로드됨
  
  return menus;
});

/// 메뉴 상세 Provider
/// 
/// 특정 ID의 메뉴 상세 정보를 제공하는 FutureProvider입니다.
/// 
/// **매개변수:**
/// - [menuId]: 조회할 메뉴의 고유 ID
/// 
/// **반환값:**
/// - [MenuItem?]: 메뉴 정보 (존재하지 않는 경우 null)
/// 
/// **성능 최적화:**
/// - `keepAlive`를 통해 데이터 캐싱 및 불필요한 재로딩 방지
/// 
/// **사용 예시:**
/// ```dart
/// final menuDetailAsync = ref.watch(menuDetailProvider(menuId));
/// menuDetailAsync.when(
///   data: (menu) => MenuDetailWidget(menu: menu),
///   loading: () => CircularProgressIndicator(),
///   error: (error, stack) => ErrorWidget(),
/// );
/// ```
final menuDetailProvider = FutureProvider.family<MenuItem?, String>((ref, menuId) async {
  final menuService = ref.watch(menuServiceProvider);
  final menu = await menuService.getMenuById(menuId);
  
  // keepAlive 제거: 변경사항이 즉시 반영되도록 함
  
  return menu;
});

/// 관리자용 메뉴 목록 Provider
/// 
/// 모든 메뉴 목록을 제공하는 FutureProvider입니다 (품절 포함).
/// 관리자 화면에서 사용하며, 품절 메뉴도 포함하여 반환합니다.
/// 
/// **성능 최적화:**
/// - `keepAlive`를 통해 데이터 캐싱 및 불필요한 재로딩 방지
/// 
/// **사용 예시:**
/// ```dart
/// final adminMenuListAsync = ref.watch(adminMenuListProvider);
/// adminMenuListAsync.when(
///   data: (menus) => AdminMenuListWidget(menus: menus),
///   loading: () => CircularProgressIndicator(),
///   error: (error, stack) => ErrorWidget(),
/// );
/// ```
final adminMenuListProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuService = ref.watch(menuServiceProvider);
  final menus = await menuService.getAllMenus();
  
  // keepAlive 제거: 변경사항이 즉시 반영되도록 함
  
  return menus;
});

