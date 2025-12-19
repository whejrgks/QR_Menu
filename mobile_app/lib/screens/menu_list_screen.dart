import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import '../services/menu_service_impl.dart';
import '../models/menu_item.dart';

/// 메뉴 목록 화면 위젯
class MenuListScreen extends StatelessWidget {
  final MenuService menuService = MenuServiceImpl();

  const MenuListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 목록'),
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

