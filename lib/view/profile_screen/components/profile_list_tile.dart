import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key key,
    @required this.size,
    this.data,
    this.titleName,
    this.field,
    this.leadingIcon,
  }) : super(key: key);

  final Size size;
  final Map<String, dynamic> data;
  final String titleName, field, leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        leadingIcon,
        width: size.width * 0.06,
      ),
      title: Text(titleName),
      subtitle: Text(data[field]),
      trailing: Image.asset("assets/images/Icon material-edit.png",
          width: size.width * 0.06),
    );
  }
}
