import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor ?? Colors.grey),
      title: Text(
        title, 
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor ?? colors.onSurface,
        )
      ),
      subtitle: subtitle != null && subtitle!.isNotEmpty 
          ? Text(subtitle!, style: TextStyle(color: (textColor ?? colors.onSurface).withOpacity(0.6))) 
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
