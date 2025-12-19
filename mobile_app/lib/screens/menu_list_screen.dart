import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';

/// 메뉴 목록 화면 위젯
class MenuListScreen extends StatelessWidget {
  final MenuService menuService;

  MenuListScreen({Key? key}) 
      : menuService = MenuServiceImpl(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<MenuItem>>(
        future: menuService.getAvailableMenus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('메뉴를 불러올 수 없습니다.'));
          }

          final menus = snapshot.data!;
          
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
      ),
    );
  }
}

