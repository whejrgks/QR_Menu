import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';

/// 관리자 메뉴 관리 화면
class AdminMenuManageScreen extends ConsumerStatefulWidget {
  const AdminMenuManageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminMenuManageScreen> createState() => _AdminMenuManageScreenState();
}

class _AdminMenuManageScreenState extends ConsumerState<AdminMenuManageScreen> {
  // 로컬 상태: 메뉴 상태 토글을 위한 임시 상태 관리
  // 실제 구현에서는 StateNotifier를 사용하여 전역 상태로 관리하는 것이 좋습니다
  List<MenuItem> _localMenus = [];

  @override
  void initState() {
    super.initState();
  }

  void _refreshMenus() {
    // Provider를 통해 메뉴 목록 새로고침
    ref.invalidate(adminMenuListProvider);
  }

  Future<void> _toggleAvailability(MenuItem menu) async {
    // 품절 상태 토글 (실제로는 API 호출)
    setState(() {
      final index = _localMenus.indexWhere((m) => m.id == menu.id);
      if (index != -1) {
        // Mock 데이터는 불변 객체이므로 새로 생성
        final updatedMenu = MenuItem(
          id: menu.id,
          name: menu.name,
          description: menu.description,
          price: menu.price,
          imageUrl: menu.imageUrl,
          allergens: menu.allergens,
          isAvailable: !menu.isAvailable,
        );
        _localMenus[index] = updatedMenu;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          menu.isAvailable
              ? '${menu.name}을(를) 품절 처리했습니다.'
              : '${menu.name}을(를) 판매 가능으로 변경했습니다.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
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
          // 로컬 상태가 비어있거나 길이가 다르면 Provider 데이터로 동기화
          if (_localMenus.isEmpty || _localMenus.length != menus.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _localMenus = List.from(menus);
                });
              }
            });
            // 초기 로딩 중에는 Provider 데이터를 직접 사용
            return ListView.builder(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return _buildMenuCard(menu);
              },
            );
          }
          
          // 로컬 상태가 준비되면 로컬 상태 사용
          return ListView.builder(
            itemCount: _localMenus.length,
            itemBuilder: (context, index) {
              final menu = _localMenus[index];
              return _buildMenuCard(menu);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '메뉴를 불러올 수 없습니다.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '인터넷 연결을 확인하거나\n잠시 후 다시 시도해주세요.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _refreshMenus,
                    icon: const Icon(Icons.refresh),
                    label: const Text('다시 시도'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('메뉴 추가 기능은 향후 구현 예정입니다.'),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: '메뉴 추가',
      ),
    );
  }

  /// 메뉴 카드 위젯 빌드
  Widget _buildMenuCard(MenuItem menu) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: menu.isAvailable ? Colors.green : Colors.red,
          child: Icon(
            menu.isAvailable ? Icons.check : Icons.close,
            color: Colors.white,
          ),
        ),
        title: Text(
          menu.name,
          style: TextStyle(
            decoration: menu.isAvailable
                ? TextDecoration.none
                : TextDecoration.lineThrough,
            color: menu.isAvailable ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text('${menu.price.toStringAsFixed(0)}원'),
        trailing: Switch(
          value: menu.isAvailable,
          onChanged: (_) => _toggleAvailability(menu),
        ),
        onTap: () {
          // 메뉴 상세 정보 표시
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(menu.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('가격: ${menu.price.toStringAsFixed(0)}원'),
                  const SizedBox(height: 8),
                  Text('설명: ${menu.description}'),
                  if (menu.allergens != null && menu.allergens!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('알레르기: ${menu.allergens!.join(", ")}'),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '상태: ${menu.isAvailable ? "판매 중" : "품절"}',
                    style: TextStyle(
                      color: menu.isAvailable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('닫기'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

