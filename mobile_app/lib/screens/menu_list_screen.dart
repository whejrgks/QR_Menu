import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';

/// 메뉴 목록 화면 위젯
class MenuListScreen extends ConsumerWidget {
  const MenuListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuListAsync = ref.watch(menuListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            tooltip: '관리자 모드',
          ),
        ],
      ),
      body: menuListAsync.when(
        data: (menus) {
          if (menus.isEmpty) {
            return const Center(child: Text('메뉴가 없습니다.'));
          }
          
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(
          child: Text('메뉴를 불러올 수 없습니다.'),
        ),
      ),
    );
  }
}

