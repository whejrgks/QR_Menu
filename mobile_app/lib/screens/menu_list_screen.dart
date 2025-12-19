import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/error_widget.dart';
import '../utils/format_utils.dart';
import '../utils/image_utils.dart';
import '../constants/app_constants.dart';
import 'menu_detail_screen.dart';

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
            return const EmptyStateWidget(
              icon: Icons.restaurant_menu,
              message: '메뉴가 없습니다.',
            );
          }
          
          return ListView.builder(
            itemCount: menus.length,
            // 성능 최적화: 자동 keep-alive 비활성화 (메모리 절약)
            addAutomaticKeepAlives: false,
            // 성능 최적화: 리빌드 경계 추가 (불필요한 리빌드 방지)
            addRepaintBoundaries: true,
            // 성능 최적화: 아이템 높이 캐싱 (스크롤 성능 향상)
            cacheExtent: 500,
            itemBuilder: (context, index) {
              final menu = menus[index];
              return ListTile(
                leading: menu.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: buildMenuThumbnail(
                          imageUrl: menu.imageUrl!,
                          size: 60,
                        ),
                      )
                    : const Icon(Icons.restaurant_menu),
                title: Text(menu.name),
                subtitle: Text(formatPriceSimple(menu.price)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuDetailScreen(menuId: menu.id),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) {
          return ErrorDisplayWidget(
            title: '메뉴를 불러올 수 없습니다.',
            subtitle: '인터넷 연결을 확인하거나\n잠시 후 다시 시도해주세요.',
            onRetry: () {
              ref.invalidate(menuListProvider);
            },
          );
        },
      ),
    );
  }
}

