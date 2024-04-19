import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:servit_project_version_2/features/services/presentation/widget/network_image_get.dart';

import '../../domain/entities/services_entity.dart';

class ServicesItem extends StatefulWidget {
  final ServicesEntity data;
  const ServicesItem({super.key, required this.data});

  @override
  State<ServicesItem> createState() => _ServicesItemState();
}

class _ServicesItemState extends State<ServicesItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const NetworkImageGet(
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.serviceName.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(4),
                    RatingBar.builder(
                      initialRating: widget.data.rate!,
                      itemCount: widget.data.rateCount!,
                      allowHalfRating: true,
                      itemSize: 18,
                      itemPadding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {},
                      ignoreGestures: true,
                    ),
                    const Gap(4),
                    Text(
                      'Category : ${widget.data.category.toString()}',
                      textAlign: TextAlign.start,
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
