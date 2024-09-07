import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableActions extends StatelessWidget {
  final String blogId;

  SlidableActions({required this.blogId});

  Future<void> _deleteBlog(BuildContext context) async {
    bool confirmDelete = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Blog'),
              content: const Text('Are you sure you want to delete this blog?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmDelete) {
      await FirebaseFirestore.instance.collection('blogs').doc(blogId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Blog deleted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (context) => _deleteBlog(context),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}
