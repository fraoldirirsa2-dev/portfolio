import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/project.dart';
import '../services/project_service.dart';
import '../theme.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _auth = FirebaseAuth.instance;
  final _service = ProjectService();
  User? _user;
  String? _email;
  String? _password;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((user) {
      setState(() => _user = user);
    });
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 64, color: AppColors.primary),
                const SizedBox(height: 24),
                TextField(
                  onChanged: (v) => _email = v,
                  decoration: _inputDeco('Email'),
                  style: const TextStyle(color: AppColors.text),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (v) => _password = v,
                  obscureText: true,
                  decoration: _inputDeco('Password'),
                  style: const TextStyle(color: AppColors.text),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: AppColors.card,
        actions: [
          TextButton(
            onPressed: () => _auth.signOut(),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _showProjectDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Project'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Project>>(
                stream: _service.streamProjects(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final projects = snapshot.data!;
                  if (projects.isEmpty) {
                    return const Center(
                      child: Text(
                        'No projects yet. Add one!',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Card(
                        color: AppColors.card,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(
                            project.title,
                            style: const TextStyle(color: AppColors.text),
                          ),
                          subtitle: Text(
                            project.description,
                            style: const TextStyle(color: AppColors.muted),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.primary,
                                ),
                                onPressed: () => _showProjectDialog(
                                  context,
                                  project: project,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    _service.deleteProject(project.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectDialog(BuildContext context, {Project? project}) {
    final titleCtrl = TextEditingController(text: project?.title ?? '');
    final descCtrl = TextEditingController(text: project?.description ?? '');
    final imageCtrl = TextEditingController(text: project?.imageUrl ?? '');
    final tagsCtrl = TextEditingController(
      text: project?.tags.join(', ') ?? '',
    );
    final linksCtrl = TextEditingController(
      text:
          project?.links.entries.map((e) => '${e.key}:${e.value}').join(', ') ??
          '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(
          project == null ? 'Add Project' : 'Edit Project',
          style: const TextStyle(color: AppColors.text),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogField(titleCtrl, 'Title'),
              _dialogField(descCtrl, 'Description', maxLines: 3),
              _dialogField(imageCtrl, 'Image URL'),
              _dialogField(tagsCtrl, 'Tags (comma separated)'),
              _dialogField(linksCtrl, 'Links (Label:URL, comma separated)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final tags = tagsCtrl.text
                  .split(',')
                  .map((s) => s.trim())
                  .where((s) => s.isNotEmpty)
                  .toList();
              final links = <String, String>{};
              for (final pair in linksCtrl.text.split(',')) {
                final parts = pair.split(':');
                if (parts.length >= 2) {
                  links[parts[0].trim()] = parts.sublist(1).join(':').trim();
                }
              }

              final newProject = Project(
                id: project?.id ?? '',
                title: titleCtrl.text.trim(),
                description: descCtrl.text.trim(),
                tags: tags,
                imageUrl: imageCtrl.text.trim(),
                links: links,
                createdAt: project?.createdAt ?? DateTime.now(),
              );

              if (project == null) {
                await _service.addProject(newProject);
              } else {
                await _service.updateProject(project.id, newProject);
              }
              if (context.mounted) Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _dialogField(
    TextEditingController c,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        style: const TextStyle(color: AppColors.text),
        decoration: _inputDeco(label),
      ),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.muted),
      filled: true,
      fillColor: AppColors.bg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}
