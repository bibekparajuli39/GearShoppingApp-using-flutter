import 'package:flutter/material.dart';

class Profiletile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const Profiletile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.subtitle,
  });

  @override
  State<Profiletile> createState() => _ProfiletileState();
}

class _ProfiletileState extends State<Profiletile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(widget.icon, size: 30),
        title: Text(widget.title, style: TextStyle(fontSize: 16)),
        subtitle: Text(widget.subtitle, style: TextStyle(fontSize: 14)),
        onTap: widget.onTap,
      ),
    );
  }
}
