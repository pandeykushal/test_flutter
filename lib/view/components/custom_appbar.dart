import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:np_com_pandeykushal/view/screens/base_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.amber,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
