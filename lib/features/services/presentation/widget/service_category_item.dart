import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ServiceCategoryItem extends StatelessWidget {
  final String title;

  const ServiceCategoryItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(
                bottom: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: switch (title) {
                "Perbaikan" => const Icon(
                    Icons.build_circle_outlined,
                    color: FlexColor.sakuraLightPrimary,
                    size: 42,
                  ),
                "Konstruksi" => const Icon(
                    Icons.construction_outlined,
                    color: FlexColor.sakuraLightPrimary,
                    size: 42,
                  ),
                "Rumah" => const Icon(
                    Icons.house_outlined,
                    color: FlexColor.sakuraLightPrimary,
                    size: 42,
                  ),
                "Digital" => const Icon(
                    Icons.smartphone_outlined,
                    color: FlexColor.sakuraLightPrimary,
                    size: 42,
                  ),
                _ => const Icon(
                    Icons.broken_image,
                    color: FlexColor.sakuraLightPrimary,
                    size: 42,
                  ),
              },
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
