import 'package:flutter/material.dart';

enum AppBarActionType {
  close, // "x" button to close the current process and return to main screen
  overflowMenu, // three-dot menu (not implemented)
  none, // No actions
}

class ComicSansAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton; // Visibility of the back arrow
  final bool showCloseButton; // Visibility of the close button
  final AppBarActionType actionType; // Tipo di azione principale
  final VoidCallback? onOverflowMenuPressed; // Callback per il menu a tre puntini
  final VoidCallback? onCloseButtonPressed;

  const ComicSansAppBar({
    super.key,
    this.title = 'Comic Sans',
    this.showBackButton = false,
    this.showCloseButton = false,
    this.actionType = AppBarActionType.none,
    this.onOverflowMenuPressed,
    this.onCloseButtonPressed
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actionsList = [];

    // Main action based on the actionType
    if (actionType == AppBarActionType.close) {
      actionsList.add(
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onCloseButtonPressed ?? () { // Use the given callback or the default
              Navigator.pushNamed(context, '/'); // Return to the main screen
          },
        ),
      );
    } else if (actionType == AppBarActionType.overflowMenu) {
      actionsList.add(
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onOverflowMenuPressed ?? () {
            // Implementa qui la logica di default per l'overflow menu
            // o lascia che sia gestita dalla pagina che usa l'AppBar
            print("Overflow menu pressed (default action)");
            // Esempio: Scaffold.of(context).openEndDrawer(); // Se hai un endDrawer
            // O mostra un PopupMenuButton
          },
        ),
      );
    }



    return AppBar(
      toolbarHeight: 40,
      title: title != null ?
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(title!)
            )
          ],
        )
      : null, // title not given
      automaticallyImplyLeading: false,
      leading: showBackButton ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
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