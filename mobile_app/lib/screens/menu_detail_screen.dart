import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../models/menu_item.dart';

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
            return const Center(child: Text('메뉴를 찾을 수 없습니다.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 표시
                if (menu.imageUrl != null)
                  Image.network(
                    menu.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                
                const SizedBox(height: 16),
                
                // 가격 표시 (원 단위)
                Text(
                  '${menu.price.toStringAsFixed(0)}원',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                
                const SizedBox(height: 8),
                
                // 설명 표시
                Text(
                  menu.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                
                const SizedBox(height: 16),
                
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(
          child: Text('메뉴를 찾을 수 없습니다.'),
        ),
      ),
    );
  }
}

