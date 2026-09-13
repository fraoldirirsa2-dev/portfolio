import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/project.dart';

class ProjectService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _projectsRef => _db.collection('projects');

  // Real-time stream of all projects, newest first.
  Stream<List<Project>> streamProjects() {
    return _projectsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList(),
        );
  }

  // Add a new project.
  Future<void> addProject(Project project) async {
    await _projectsRef.add(project.toFirestore());
  }

  // Update an existing project.
  Future<void> updateProject(String id, Project project) async {
    await _projectsRef.doc(id).update(project.toFirestore());
  }

  // Delete a project.
  Future<void> deleteProject(String id) async {
    await _projectsRef.doc(id).delete();
  }
}
