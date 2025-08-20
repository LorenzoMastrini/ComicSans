import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/SampleData.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ChangeCreditCardScreen.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/screens/ChangeShippingAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/comic.dart';
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
              Text("Riepilogo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      child: SizedBox(
                        width: 150,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.asset(
                            widget.comic.coverPath!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.comic.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                        Text("Prezzo: ${widget.comic.offerPrice ?? widget.comic.price}€", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                        Text("Spedizione: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                        SizedBox(height: 150),
                        Text("Totale: ${widget.comic.offerPrice ?? widget.comic.price}€", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
              SizedBox(height: 20),
              Text("Metodo di spedizione", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text("Spedisci a casa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
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
                title: Text("Punto di ritiro", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
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
              Text("Indirizzo di spedizione", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                              )
                            ),
                            Text(userProviderWatch.loggedInUser!.address?.address ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                            Text(userProviderWatch.loggedInUser!.address?.cap.toString() ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ChangeShippingAddressScreen()
                          ));
                        },
                        child: Text("Cambia", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, decoration: TextDecoration.underline))
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
                              Text("Armadietto 1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text("Via Banca 3", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text("06055", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ]
                    )
                  ),
                SizedBox(height: 20),
                Text("Pagamento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListTile(
                  title: Text("Carta di credito", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
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
                            children: userProviderWatch.loggedInUser!.card != null
                            ? [
                              Text(userProviderWatch.loggedInUser!.card!.holder, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text(maskCardNumber(userProviderWatch.loggedInUser!.card!.number.toString()), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text(userProviderWatch.loggedInUser!.card!.expiration, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text(userProviderWatch.loggedInUser!.card!.cvv.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
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
                          child: Text("Cambia", style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline))
                        ),
                      ]
                    )
                  ),
                ListTile(
                  title: Text("PayPal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
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
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ComicSansButton(
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
                        userProviderRead.updatePuchases(widget.comic);
                        widget.comic.seller.sellings.add(widget.comic);
                        widget.comic.seller.comicsSale.remove(widget.comic);
                        SampleData.allComics.remove(widget.comic);

                        userProviderRead.setJustPurchased(true);
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    text: "Paga"
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}