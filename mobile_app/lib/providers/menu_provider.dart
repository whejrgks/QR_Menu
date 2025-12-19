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
final menuListProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuService = ref.watch(menuServiceProvider);
  return await menuService.getAvailableMenus();
});

/// 메뉴 상세 Provider
/// 특정 ID의 메뉴 상세 정보를 제공하는 FutureProvider
final menuDetailProvider = FutureProvider.family<MenuItem?, String>((ref, menuId) async {
  final menuService = ref.watch(menuServiceProvider);
  return await menuService.getMenuById(menuId);
});

/// 관리자용 메뉴 목록 Provider
/// 모든 메뉴 목록을 제공하는 FutureProvider (품절 포함)
final adminMenuListProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuService = ref.watch(menuServiceProvider);
  return await menuService.getAllMenus();
});

