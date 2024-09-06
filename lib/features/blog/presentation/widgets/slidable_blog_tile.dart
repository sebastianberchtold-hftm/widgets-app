import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableBlogTile extends StatelessWidget {
  final String blogId;
  final Map<String, dynamic> blogData;

  const SlidableBlogTile({
    Key? key,
    required this.blogId,
    required this.blogData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(blogId),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFirestore.instance
                  .collection('blogs')
                  .doc(blogId)
                  .delete();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        leading: blogData['imageUrl'] != null
            ? Image.network(
                blogData['imageUrl'],
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              )
            : Container(
                width: 50,
                height: 50,
                color: Colors.grey,
                child: Icon(Icons.image, color: Colors.white),
              ),
        title: Text(blogData['title'] ?? 'No Title'),
        subtitle: Text(blogData['content'] ?? 'No Content'),
      ),
    );
  }
}
