import 'dart:io';
import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ChangeCreditCardScreen.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/screens/ChangeShippingAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/comic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class PurchaseScreen extends StatefulWidget{
  final Comic comic;

  const PurchaseScreen({super.key, required this.comic});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}



class _PurchaseScreenState extends State<PurchaseScreen> {
  Shipping? shipping = Shipping.home;
  PaymentMethod? payment = PaymentMethod.creditCard;

  String maskCardNumber(String number) {
    if (number.length < 4) return number;
    String last4 = number.substring(number.length - 4);
    return '**** **** **** $last4';
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderRead = context.read<UserProvider>();
    final UserProvider userProviderWatch = context.watch<UserProvider>();

    return Scaffold(
      appBar: ComicSansAppBar(
        title: "Pagamento",
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Riepilogo", style: Theme.of(context).textTheme.titleMedium),
              Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: SizedBox(
                      width: 150,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: widget.comic.coverPath.startsWith('assets/')
                          ? Image.asset(widget.comic.coverPath, fit: BoxFit.fitHeight)
                          : widget.comic.coverPath.isEmpty || !File(widget.comic.coverPath).existsSync()
                            ? Image.asset('assets/no_image.png', fit: BoxFit.fitHeight)
                            : Image.file(File(widget.comic.coverPath), fit: BoxFit.fitHeight,),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.comic.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Prezzo: ',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${widget.comic.offerPrice ?? widget.comic.price}€',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Spedizione: ',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '2€',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]
                          ),
                        ),
                        SizedBox(height: 150),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Totale: ',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${(widget.comic.offerPrice ?? widget.comic.price) + 2}€',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text("Metodo di spedizione", style: Theme.of(context).textTheme.titleMedium),
              ListTile(
                title: Text("Spedisci a casa", style: Theme.of(context).textTheme.headlineMedium),
                leading: Radio<Shipping>(
                  value: Shipping.home,
                  groupValue: shipping,
                  onChanged: (Shipping? value) {
                    setState(() {
                      shipping = value;
                    });
                  }
                )
              ),
              ListTile(
                title: Text("Punto di ritiro", style: Theme.of(context).textTheme.headlineMedium),
                leading: Radio<Shipping>(
                  value: Shipping.retirePoint,
                  groupValue: shipping,
                  onChanged: (Shipping? value) {
                    setState(() {
                      shipping = value;
                   });
                 }
                ),
              ),
              SizedBox(height: 20),
              Text("Indirizzo di spedizione", style: Theme.of(context).textTheme.titleMedium),
              if(shipping == Shipping.home)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                      )
                    ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userProviderWatch.loggedInUser!.address?.name ?? ''} ${userProviderWatch.loggedInUser?.address?.lastName ?? ''}",
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                            ),
                            Text(
                              userProviderWatch.loggedInUser!.address?.address ?? '',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                            ),
                            Text(
                              userProviderWatch.loggedInUser!.address?.cap.toString() ?? '',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ChangeShippingAddressScreen()
                          ));
                        },
                        child: Text(
                          "Cambia",
                          style: TextStyle(
                            color: quaternary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: quaternary,
                          ),
                        )
                      ),
                    ]
                  )
                ),
                if(shipping == Shipping.retirePoint)
                  Container(
                  padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(128),
                        )
                      ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Armadietto 1", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)),
                              Text("Via Banca 3", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)),
                              Text("06055", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)),
                            ],
                          ),
                        ),
                      ]
                    )
                  ),
                SizedBox(height: 20),
                Text("Pagamento", style: Theme.of(context).textTheme.titleMedium),
                ListTile(
                  title: Text("Carta di credito", style: Theme.of(context).textTheme.headlineMedium),
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.creditCard,
                    groupValue: payment,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        payment = value;
                      });
                    }
                  )
                ),
                if(payment == PaymentMethod.creditCard)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(128),
                        )
                      ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: userProviderWatch.loggedInUser!.card != null
                            ? [
                              Text(
                                userProviderWatch.loggedInUser!.card!.holder,
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                              ),
                              Text(
                                maskCardNumber(userProviderWatch.loggedInUser!.card!.number.toString()),
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                              ),
                              Text(
                                userProviderWatch.loggedInUser!.card!.expiration,
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                              ),
                              Text(
                                userProviderWatch.loggedInUser!.card!.cvv.toString(),
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary)
                              ),
                            ]
                            : [
                              Text("Nessuna carta di credito inserita", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ChangeCreditCardScreen()
                            ));
                          },
                          child: Text(
                            "Cambia",
                            style: TextStyle(
                              color: quaternary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: quaternary,
                            ),
                          )
                        ),
                      ]
                    )
                  ),
                ListTile(
                  title: Text("PayPal", style: Theme.of(context).textTheme.headlineMedium),
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.payPal,
                    groupValue: payment,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        payment = value;
                      });
                    }
                  )
                ),
                SizedBox(height: 20),
                ComicSansButton(
                  onPressed: () {
                    bool canPurchase = true;
                    if(shipping == Shipping.home && userProviderWatch.loggedInUser!.address == null) {
                      canPurchase = false;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Inserisci un indirizzo di spedizione!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK")
                            )
                          ]
                        )
                      );
                    }
                    if(payment == PaymentMethod.creditCard && userProviderWatch.loggedInUser!.card == null) {
                      canPurchase = false;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Inserisci una carta di credito!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK")
                            )
                          ]
                        )
                      );
                    }
                    if(payment == PaymentMethod.payPal && userProviderWatch.loggedInUser!.connectedAccount == false) {
                      canPurchase = false;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Account non connesso!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK")
                            )
                          ]
                        )
                      );
                    }
                    if(canPurchase) {
                      final comicsProvider = context.read<ComicsProvider>();

                      userProviderRead.updatePurchases(widget.comic);
                      widget.comic.seller.sellings.add(widget.comic);
                      widget.comic.seller.comicsSale.remove(widget.comic);
                      comicsProvider.removeComic(widget.comic);
                      userProviderRead.setJustPurchased(true);
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  text: "Paga"
                ),
            ],
          ),
        ),
      ),
    );
  }
}