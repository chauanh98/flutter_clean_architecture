import 'package:flutter/material.dart';

import '../features/attraction/domain/entities/attraction.dart';

class AttractionItem extends StatelessWidget {
  final Attraction attraction;

  const AttractionItem({super.key, required this.attraction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            attraction.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 48);
            },
          ),
        ),
      ),
      title: Text(attraction.name),
      subtitle: Text(attraction.address),
    );
  }
}

