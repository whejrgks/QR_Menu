import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../utils/format_utils.dart';
import '../utils/image_utils.dart';
import '../constants/app_constants.dart';

/// 메뉴 상세 화면 위젯
class MenuDetailScreen extends ConsumerWidget {
  final String menuId;

  const MenuDetailScreen({
    Key? key,
    required this.menuId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuDetailAsync = ref.watch(menuDetailProvider(menuId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 상세'),
      ),
      body: menuDetailAsync.when(
        data: (menu) {
          if (menu == null) {
            return MenuNotFoundWidget(
              onBack: () => Navigator.pop(context),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppPadding.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 표시
                if (menu.imageUrl != null)
                  buildNetworkImage(
                    imageUrl: menu.imageUrl!,
                    width: double.infinity,
                    height: AppImageSize.menuDetailHeight,
                    fit: BoxFit.cover,
                  ),
                
                const SizedBox(height: AppPadding.medium),
                
                // 가격 표시 (원 단위)
                Text(
                  formatPriceSimple(menu.price),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                
                const SizedBox(height: AppPadding.small),
                
                // 설명 표시
                Text(
                  menu.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                
                const SizedBox(height: AppPadding.medium),
                
                // 알레르기 정보 표시
                const Text(
                  '알레르기 정보',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                
                if (menu.allergens != null && menu.allergens!.isNotEmpty)
                  ...menu.allergens!.map((allergen) => Text(allergen)),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) {
          return ErrorDisplayWidget(
            title: '메뉴를 불러올 수 없습니다.',
            subtitle: '인터넷 연결을 확인하거나\n잠시 후 다시 시도해주세요.',
            onRetry: () {
              ref.invalidate(menuDetailProvider(menuId));
            },
            trailingAction: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('돌아가기'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

