import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';

/// MenuService Provider
/// MenuService 인스턴스를 제공하는 Provider
final menuServiceProvider = Provider<MenuService>((ref) {
  return MenuServiceImpl();
});

/// 메뉴 목록 Provider
/// 판매 가능한 메뉴 목록을 제공하는 FutureProvider
/// 성능 최적화: keepAlive를 통해 데이터 캐싱 및 불필요한 재로딩 방지
final menuListProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuService = ref.watch(menuServiceProvider);
  final menus = await menuService.getAvailableMenus();
  
  // 데이터 캐싱을 위한 keepAlive 설정
  ref.keepAlive();
  
  return menus;
});

/// 메뉴 상세 Provider
/// 특정 ID의 메뉴 상세 정보를 제공하는 FutureProvider
/// 성능 최적화: keepAlive를 통해 데이터 캐싱 및 불필요한 재로딩 방지
final menuDetailProvider = FutureProvider.family<MenuItem?, String>((ref, menuId) async {
  final menuService = ref.watch(menuServiceProvider);
  final menu = await menuService.getMenuById(menuId);
  
  // 데이터 캐싱을 위한 keepAlive 설정
  ref.keepAlive();
  
  return menu;
});

/// 관리자용 메뉴 목록 Provider
/// 모든 메뉴 목록을 제공하는 FutureProvider (품절 포함)
/// 성능 최적화: keepAlive를 통해 데이터 캐싱 및 불필요한 재로딩 방지
final adminMenuListProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuService = ref.watch(menuServiceProvider);
  final menus = await menuService.getAllMenus();
  
  // 데이터 캐싱을 위한 keepAlive 설정
  ref.keepAlive();
  
  return menus;
});

