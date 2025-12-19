import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// 스켈레톤 로딩 위젯
/// 
/// 로딩 중일 때 표시하는 스켈레톤 UI

/// 메뉴 목록 스켈레톤
class MenuListSkeleton extends StatelessWidget {
  final int itemCount;

  const MenuListSkeleton({
    Key? key,
    this.itemCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.medium,
            vertical: AppPadding.small,
          ),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.small),
            child: Row(
              children: [
                // 이미지 스켈레톤
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: AppPadding.medium),
                // 텍스트 스켈레톤
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 150,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 메뉴 상세 스켈레톤
class MenuDetailSkeleton extends StatelessWidget {
  const MenuDetailSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 스켈레톤
          Container(
            width: double.infinity,
            height: AppImageSize.menuDetailHeight,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목 스켈레톤
                Container(
                  width: 200,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: AppPadding.small),
                // 가격 스켈레톤
                Container(
                  width: 150,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: AppPadding.medium),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: AppPadding.medium),
                // 설명 제목 스켈레톤
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: AppPadding.small),
                // 설명 스켈레톤
                ...List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


