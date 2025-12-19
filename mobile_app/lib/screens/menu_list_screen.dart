import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/skeleton_widget.dart';
import '../utils/format_utils.dart';
import '../utils/image_utils.dart';
import '../utils/responsive_utils.dart';
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
          
          // 반응형 레이아웃: 태블릿/데스크톱에서는 그리드 뷰 사용
          if (ResponsiveUtils.isTablet(context) || ResponsiveUtils.isDesktop(context)) {
            final columnCount = ResponsiveUtils.getColumnCount(context);
            final padding = ResponsiveUtils.getPadding(context);
            
            return GridView.builder(
              padding: EdgeInsets.all(padding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
                crossAxisSpacing: padding,
                mainAxisSpacing: padding,
                childAspectRatio: 1.2,
              ),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return _buildMenuCard(context, menu);
              },
            );
          }
          
          // 모바일: 리스트 뷰 사용
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
              return _buildMenuCard(context, menu);
            },
          );
        },
        loading: () => const LoadingWidget(useSkeleton: true),
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

  /// 메뉴 카드 위젯 빌드
  Widget _buildMenuCard(BuildContext context, MenuItem menu) {
    final isTabletOrDesktop = ResponsiveUtils.isTablet(context) || 
                              ResponsiveUtils.isDesktop(context);
    
    if (isTabletOrDesktop) {
      // 태블릿/데스크톱: 그리드 카드
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuDetailScreen(menuId: menu.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: menu.imageUrl != null
                      ? SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: buildMenuThumbnail(
                            imageUrl: menu.imageUrl!,
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.restaurant_menu,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              // 메뉴 정보
              Padding(
                padding: const EdgeInsets.all(AppPadding.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPriceSimple(menu.price),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // 모바일: 리스트 카드
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuDetailScreen(menuId: menu.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.small),
          child: Row(
            children: [
              // 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: menu.imageUrl != null
                    ? buildMenuThumbnail(
                        imageUrl: menu.imageUrl!,
                        size: 80,
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.restaurant_menu,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(width: AppPadding.medium),
              // 메뉴 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menu.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatPriceSimple(menu.price),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppPadding.small),
              // 화살표 아이콘
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

