import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comics_provider.dart';

enum AppBarActionType {
  close, // "x" button to close the current process and return to main screen
  overflowMenu, // three-dot menu (not implemented)
  none, // No actions
  reset
}

class ComicSansAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // Visibility of the back arrow
  final bool showCloseButton; // Visibility of the close button
  final AppBarActionType actionType; // Tipo di azione principale
  final VoidCallback? onOverflowMenuPressed; // Callback per il menu a tre puntini
  final VoidCallback? onCloseButtonPressed;
  final VoidCallback? onResetPressed;
  final Color backgroundColor;
  final Color iconColor;

  const ComicSansAppBar({
    super.key,
    this.title = '',
    this.showBackButton = false,
    this.showCloseButton = false,
    this.actionType = AppBarActionType.none,
    this.onOverflowMenuPressed,
    this.onCloseButtonPressed,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.black,
    this.onResetPressed
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actionsList = [];

    // Main action based on the actionType
    if (actionType == AppBarActionType.close) {
      actionsList.add(
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onCloseButtonPressed ?? () async { // Use default callback or the given one
            await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("Interrompendo il processo, i dati inseriti andranno persi."),
                actions: [
                  TextButton(
                    child: Text("Annulla"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: Text("Conferma"),
                    onPressed: (){
                      Provider.of<SellInfoProvider>(context, listen: false).resetInformations();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', // return to the main screen
                        (route) => false, // remove from the stack all the visited routes
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    else if (actionType == AppBarActionType.overflowMenu) {
      actionsList.add(
        PopupMenuButton(
          icon: Icon(Icons.more_vert, color: iconColor),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Segnala"),
                onTap: () {
                  print("Opzione 1 selezionata");
                },
              ),
              PopupMenuItem(
                child: Text("Condividi"),
                onTap: () {
                  print("Opzione 2 selezionata");
                },
              )
            ];
          },
        )
        /*IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onOverflowMenuPressed ?? () {
            // Implementa qui la logica di default per l'overflow menu
            // o lascia che sia gestita dalla pagina che usa l'AppBar
            print("Overflow menu pressed (default action)");
            // Esempio: Scaffold.of(context).openEndDrawer(); // Se hai un endDrawer
            // O mostra un PopupMenuButton
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Segnala"),
                    onTap: () {
                      print("Opzione 1 selezionata");
                    },
                  ),
                  PopupMenuItem(
                    child: Text("Condividi"),
                    onTap: () {
                      print("Opzione 2 selezionata");
                    },
                  )
                ];
              },
            );
          },
        ),*/
      );
    }
    else if (actionType == AppBarActionType.reset) {
      actionsList.add(
        TextButton(
          child: Text("Reset", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18, decoration: TextDecoration.underline)),
          onPressed: onResetPressed ?? () {
            //Provider.of<ComicsProvider>(context, listen: false).resetInformations();
            context.read<ComicsProvider>().resetInformations();
          },
        )
      );
    }

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(title)
          )
        ],
      ), // title not given
      automaticallyImplyLeading: false,
      leading: showBackButton ? IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.black,),
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