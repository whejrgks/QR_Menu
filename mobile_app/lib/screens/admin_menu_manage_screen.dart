import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/menu_form_dialog.dart';
import '../utils/format_utils.dart';
import '../utils/image_utils.dart';
import '../constants/app_constants.dart';

/// 관리자 메뉴 관리 화면
class AdminMenuManageScreen extends ConsumerStatefulWidget {
  const AdminMenuManageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminMenuManageScreen> createState() => _AdminMenuManageScreenState();
}

class _AdminMenuManageScreenState extends ConsumerState<AdminMenuManageScreen> {
  void _refreshMenus() {
    // Provider를 통해 메뉴 목록 새로고침
    ref.invalidate(adminMenuListProvider);
    ref.invalidate(menuListProvider); // 고객 화면도 새로고침
  }

  Future<void> _toggleAvailability(MenuItem menu) async {
    // MenuService를 통해 품절 상태 업데이트
    final menuService = ref.read(menuServiceProvider);
    final newAvailability = !menu.isAvailable;
    
    final updatedMenu = await menuService.updateMenuAvailability(
      menu.id,
      newAvailability,
    );

    if (updatedMenu != null) {
      // Provider를 invalidate하여 변경사항 반영
      ref.invalidate(adminMenuListProvider);
      ref.invalidate(menuListProvider); // 고객 화면도 새로고침
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            newAvailability
                ? '${menu.name}을(를) 판매 가능으로 변경했습니다.'
                : '${menu.name}을(를) 품절 처리했습니다.',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('메뉴 상태 변경에 실패했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _addMenu() async {
    final result = await showDialog<MenuItem>(
      context: context,
      builder: (context) => const MenuFormDialog(),
    );

    if (result != null) {
      final menuService = ref.read(menuServiceProvider);
      await menuService.addMenu(result);
      
      // Provider를 invalidate하여 변경사항 반영
      ref.invalidate(adminMenuListProvider);
      ref.invalidate(menuListProvider); // 고객 화면도 새로고침
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.name}이(가) 추가되었습니다.'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _editMenu(MenuItem menu) async {
    final result = await showDialog<MenuItem>(
      context: context,
      builder: (context) => MenuFormDialog(menu: menu),
    );

    if (result != null) {
      final menuService = ref.read(menuServiceProvider);
      final updatedMenu = await menuService.updateMenu(result);
      
      if (updatedMenu != null) {
        // Provider를 invalidate하여 변경사항 반영
        ref.invalidate(adminMenuListProvider);
        ref.invalidate(menuListProvider); // 고객 화면도 새로고침
        ref.invalidate(menuDetailProvider(menu.id)); // 상세 화면도 새로고침
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${result.name}이(가) 수정되었습니다.'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('메뉴 수정에 실패했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deleteMenu(MenuItem menu) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('메뉴 삭제'),
        content: Text('${menu.name}을(를) 정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final menuService = ref.read(menuServiceProvider);
      final success = await menuService.deleteMenu(menu.id);
      
      if (success) {
        // Provider를 invalidate하여 변경사항 반영
        ref.invalidate(adminMenuListProvider);
        ref.invalidate(menuListProvider); // 고객 화면도 새로고침
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${menu.name}이(가) 삭제되었습니다.'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('메뉴 삭제에 실패했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuListAsync = ref.watch(adminMenuListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshMenus,
            tooltip: '새로고침',
          ),
        ],
      ),
      body: menuListAsync.when(
        data: (menus) {
          if (menus.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '등록된 메뉴가 없습니다.\n우측 하단의 + 버튼을 눌러 메뉴를 추가하세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            );
          }
          
          return ListView.builder(
            itemCount: menus.length,
            itemBuilder: (context, index) {
              final menu = menus[index];
              return _buildMenuCard(menu);
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) {
          return ErrorDisplayWidget(
            title: '메뉴를 불러올 수 없습니다.',
            subtitle: '인터넷 연결을 확인하거나\n잠시 후 다시 시도해주세요.',
            onRetry: _refreshMenus,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMenu,
        child: const Icon(Icons.add),
        tooltip: '메뉴 추가',
      ),
    );
  }

  /// 메뉴 카드 위젯 빌드
  Widget _buildMenuCard(MenuItem menu) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.medium,
        vertical: AppPadding.small,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _editMenu(menu),
        onLongPress: () {
          // 길게 누르면 삭제 옵션 표시
          showModalBottomSheet(
            context: context,
            builder: (context) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('수정'),
                    onTap: () {
                      Navigator.pop(context);
                      _editMenu(menu);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('삭제', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pop(context);
                      _deleteMenu(menu);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.small),
          child: Row(
            children: [
              // 이미지 또는 상태 아이콘
              if (menu.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: buildMenuThumbnail(
                    imageUrl: menu.imageUrl!,
                    size: 60,
                  ),
                )
              else
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: menu.isAvailable ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    menu.isAvailable ? Icons.restaurant_menu : Icons.restaurant_menu_outlined,
                    color: menu.isAvailable ? Colors.green : Colors.red,
                    size: 30,
                  ),
                ),
              const SizedBox(width: AppPadding.medium),
              // 메뉴 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            menu.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: menu.isAvailable
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                              color: menu.isAvailable ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: menu.isAvailable ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            menu.isAvailable ? '판매중' : '품절',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPriceSimple(menu.price),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (menu.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        menu.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppPadding.small),
              // 스위치 및 편집 아이콘
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: menu.isAvailable,
                    onChanged: (_) => _toggleAvailability(menu),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () => _editMenu(menu),
                    tooltip: '수정',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

