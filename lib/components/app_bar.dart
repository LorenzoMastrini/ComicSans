/*
import 'package:flutter/material.dart';

enum appBarActionType {
  close,
  overflowMenu,
  none, // No actions
}

class ComicSansAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton; // Visibility of the back arrow
  final bool showCloseButton; // Visibility of the close button
  final appBarActionType actionType; // Tipo di azione principale
  final VoidCallback? onOverflowMenuPressed; // Callback per il menu a tre puntini
  final VoidCallback? onCloseButtonPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool modified;

  const ComicSansAppBar({
    super.key,
    this.title = '',
    this.showBackButton = true,
    this.showCloseButton = false,
    this.actionType = appBarActionType.none,
    this.onOverflowMenuPressed,
    this.onCloseButtonPressed,
    this.backgroundColor,
    this.iconColor,
    this.modified = false
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actionsList = [];
    // Main action based on the actionType
    if (actionType == appBarActionType.close) {
      actionsList.add(
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onCloseButtonPressed ?? () { // Use the given callback or the default
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      );
    } else if (actionType == appBarActionType.overflowMenu) {
      actionsList.add(
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onOverflowMenuPressed ?? () {
            print("Overflow menu pressed (default action)");
          },
        ),
      );
    }

    return AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        toolbarHeight: 50,
        scrolledUnderElevation: 0,
        title: title != null ?
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                child: Text(title!)
            )
          ],
        ) : null, // title not given
        automaticallyImplyLeading: false,
        leading: showBackButton ? IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context, modified);
            }
          },
        )
            : null,
        actions: actionsList.isNotEmpty ? actionsList : null
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
*/