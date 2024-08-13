import 'package:flutter/material.dart';

/// HomeUserList widget
final class HomeUserList extends StatelessWidget {
  const HomeUserList({required this.users, super.key});
  final List<Object> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = users[index];
        return ListTile(
          title: Text(user.toString()),
          trailing: Text(user.toString() ?? ''),
          subtitle: Text(user.toString()),
        );
      },
    );
  }
}
