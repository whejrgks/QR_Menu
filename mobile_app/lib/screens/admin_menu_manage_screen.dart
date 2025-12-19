import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';
import '../data/menu_mock_data.dart';

/// 관리자 메뉴 관리 화면
class AdminMenuManageScreen extends StatefulWidget {
  const AdminMenuManageScreen({Key? key}) : super(key: key);

  @override
  State<AdminMenuManageScreen> createState() => _AdminMenuManageScreenState();
}

class _AdminMenuManageScreenState extends State<AdminMenuManageScreen> {
  final MenuService _menuService = MenuServiceImpl();
  List<MenuItem> _allMenus = [];

  @override
  void initState() {
    super.initState();
    _loadMenus();
  }

  Future<void> _loadMenus() async {
    // 모든 메뉴 가져오기 (품절 포함)
    final menus = MenuMockData.getMenusWithOutOfStock();
    setState(() {
      _allMenus = menus;
    });
  }

  Future<void> _toggleAvailability(MenuItem menu) async {
    // 품절 상태 토글 (실제로는 API 호출)
    setState(() {
      final index = _allMenus.indexWhere((m) => m.id == menu.id);
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
        _allMenus[index] = updatedMenu;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMenus,
            tooltip: '새로고침',
          ),
        ],
      ),
      body: _allMenus.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _allMenus.length,
              itemBuilder: (context, index) {
                final menu = _allMenus[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: menu.isAvailable
                          ? Colors.green
                          : Colors.red,
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
                        color: menu.isAvailable
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                    subtitle: Text(
                      '${menu.price.toStringAsFixed(0)}원',
                    ),
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
                              if (menu.allergens != null &&
                                  menu.allergens!.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  '알레르기: ${menu.allergens!.join(", ")}',
                                ),
                              ],
                              const SizedBox(height: 8),
                              Text(
                                '상태: ${menu.isAvailable ? "판매 중" : "품절"}',
                                style: TextStyle(
                                  color: menu.isAvailable
                                      ? Colors.green
                                      : Colors.red,
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
}

