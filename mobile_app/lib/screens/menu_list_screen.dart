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
/// 
/// 고객이 QR 코드를 스캔하여 접근하는 메뉴 목록 화면입니다.
/// 
/// **기능:**
/// - 판매 가능한 메뉴 목록 표시
/// - 메뉴 클릭 시 상세 화면으로 이동
/// - 반응형 디자인 지원 (모바일: ListView, 태블릿/데스크톱: GridView)
/// - 스켈레톤 UI를 통한 로딩 상태 표시
/// - 에러 발생 시 재시도 기능 제공
/// 
/// **사용 예시:**
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => MenuListScreen()),
/// );
/// ```
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
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // 메뉴 목록 새로고침
              ref.invalidate(menuListProvider);
            },
            tooltip: '새로고침',
          ),
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
          
          // 가로로 3개씩 그리드 뷰 사용
          final padding = ResponsiveUtils.getPadding(context);
          
          return GridView.builder(
            padding: EdgeInsets.all(padding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 가로로 3개씩
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75, // 카드 비율 조정
            ),
            itemCount: menus.length,
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
    // 그리드 카드 형식 (가로 3개씩)
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
              flex: 3,
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
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            // 메뉴 정보
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menu.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      formatPriceSimple(menu.price),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

