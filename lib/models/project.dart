import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;
  final Map<String, String> links;
  final DateTime createdAt;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    required this.links,
    required this.createdAt,
  });

  factory Project.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Project(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      tags: List<String>.from(data['tags'] as List? ?? []),
      imageUrl: data['imageUrl'] as String? ?? '',
      links: Map<String, String>.from(data['links'] as Map? ?? {}),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'imageUrl': imageUrl,
      'links': links,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
