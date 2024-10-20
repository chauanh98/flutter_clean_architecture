import '../../domain/entities/attraction.dart';

class AttractionModel {
  final int id;
  final String name;
  final String introduction;
  final String address;
  final String imageUrl;
  final bool isVisible;

  AttractionModel({
    required this.id,
    required this.name,
    required this.introduction,
    required this.address,
    required this.imageUrl,
    required this.isVisible,
  });

  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    final hasImages = (json['images'] != null && json['images'].isNotEmpty);
    final imageUrl = hasImages ? json['images'][0]['src'] : '';

    return AttractionModel(
      id: json['id'],
      name: json['name'],
      introduction: json['introduction'] ?? 'No introduction available',
      address: json['address'] ?? 'No address available',
      imageUrl: imageUrl,
      isVisible: hasImages,
    );
  }

  Attraction toEntity() {
    return Attraction(
      id: id,
      name: name,
      address: address,
      imageUrl: imageUrl,
      introduction: introduction,
      isVisible: isVisible
    );
  }
}
