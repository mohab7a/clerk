import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key key,
    @required this.size,
    this.data,
    this.titleName,
    this.field,
    this.leadingIcon,
    this.trailingIcon,
    this.press,
  }) : super(key: key);

  final Size size;
  final Map<String, dynamic> data;
  final String titleName, field, leadingIcon, trailingIcon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        leadingIcon,
        width: size.width * 0.06,
      ),
      title: Text(titleName),
      subtitle: Text(data[field]),
      trailing: GestureDetector(
        onTap: press,
        child: Image.asset(trailingIcon, width: size.width * 0.06),
      ),
    );
  }
}
