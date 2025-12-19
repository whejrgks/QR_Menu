import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/skeleton_widget.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 표시
                if (menu.imageUrl != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: buildNetworkImage(
                      imageUrl: menu.imageUrl!,
                      width: double.infinity,
                      height: AppImageSize.menuDetailHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                
                Padding(
                  padding: const EdgeInsets.all(AppPadding.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 메뉴 이름
                      Text(
                        menu.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: AppPadding.small),
                      
                      // 가격 표시 (원 단위)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.medium,
                          vertical: AppPadding.small,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          formatPriceSimple(menu.price),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: AppPadding.medium),
                      
                      // 구분선
                      Divider(color: Colors.grey[300]),
                      
                      const SizedBox(height: AppPadding.medium),
                      
                      // 설명 제목
                      Text(
                        '상세 설명',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: AppPadding.small),
                      
                      // 설명 표시
                      Text(
                        menu.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: AppPadding.medium),
                      
                      // 알레르기 정보 섹션
                      if (menu.allergens != null && menu.allergens!.isNotEmpty) ...[
                        Divider(color: Colors.grey[300]),
                        const SizedBox(height: AppPadding.medium),
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.orange[700],
                              size: 24,
                            ),
                            const SizedBox(width: AppPadding.small),
                            Text(
                              '알레르기 정보',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppPadding.small),
                        Wrap(
                          spacing: AppPadding.small,
                          runSpacing: AppPadding.small,
                          children: menu.allergens!.map((allergen) {
                            return Chip(
                              label: Text(allergen),
                              backgroundColor: Colors.orange[50],
                              side: BorderSide(color: Colors.orange[300]!),
                              labelStyle: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 12,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(
          useSkeleton: true,
          customSkeleton: MenuDetailSkeleton(),
        ),
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

