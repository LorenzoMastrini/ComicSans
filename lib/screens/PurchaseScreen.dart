import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/Components/app_bar.dart';
import 'package:comicsans/screens/ChangeCreditCardScreen.dart';
import 'package:comicsans/screens/ChangeShippingAddressScreen.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';
import 'package:comicsans/SampleData.dart';

class PurchaseScreen extends StatefulWidget{
  User user;
  Comic comic;

  PurchaseScreen({super.key, required this.user, required this.comic});
  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

enum Shipping {Home, retirePoint}
enum paymentMethod {CreditCard, PayPal}

String maskCardNumber(String number) {
  if (number.length < 4) return number;
  String last4 = number.substring(number.length - 4);
  return '**** **** **** $last4';
}


class _PurchaseScreenState extends State<PurchaseScreen> {
  Shipping? shipping = Shipping.Home;
  paymentMethod? payment = paymentMethod.CreditCard;

  @override
  Widget build(BuildContext context) {
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
                              widget.comic.coverPath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.comic.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                          Text("Prezzo: "+widget.comic.price.toString() + "€", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                          Text("Spedizione: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                          SizedBox(height: 150),
                          Text("Totale: "+widget.comic.price.toString() + "€", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                SizedBox(height: 20),
                Text("Metodo di spedizione", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListTile(
                    title: Text("Spedisci a casa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    leading: Radio<Shipping>(
                      value: Shipping.Home,
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
                if(shipping == Shipping.Home)
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
                            children: widget.user.addr != null
                            ? [
                              Text(widget.user.addr!.name + " " +widget.user.addr!.lastName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text(widget.user.addr!.address, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                              Text(widget.user.addr!.cap.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                            ]
                            : [
                              Text("Nessun indirizzo inserito", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))
                            ]
                          ),
                        ),
                        GestureDetector(
                          onTap:() async {
                            final result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return ChangeShippingAddressScreen(user: widget.user);
                                }
                              )
                            );
                            if(result == true){
                              setState(() {});
                            }
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
                    leading: Radio<paymentMethod>(
                        value: paymentMethod.CreditCard,
                        groupValue: payment,
                        onChanged: (paymentMethod? value) {
                          setState(() {
                            payment = value;
                          });
                        }
                    )
                ),
                if(payment == paymentMethod.CreditCard)
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
                                children: widget.user.card != null
                                ? [
                                  Text(widget.user.card!.holder, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                  Text(maskCardNumber(widget.user.card!.number.toString()), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                  Text(widget.user.card!.expiration, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                  Text(widget.user.card!.cvv.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                ]
                                : [
                                  Text("Nessuna carta di credito inserita", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.push(context, MaterialPageRoute(
                                      builder: (context){
                                        return ChangeCreditCardScreen(user: widget.user);
                                      }
                                    )
                                  );
                                  if(result == true){
                                    setState(() {});
                                  }
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
                    leading: Radio<paymentMethod>(
                        value: paymentMethod.PayPal,
                        groupValue: payment,
                        onChanged: (paymentMethod? value) {
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
                      if(shipping == Shipping.Home && widget.user.addr == null) {
                        canPurchase = false;
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                  content: Text("Inserisci un indirizzo di spedizione!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK")
                                    )
                                  ]
                              )
                        );
                      }
                      if(payment == paymentMethod.CreditCard && widget.user.card == null) {
                        canPurchase = false;
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                    content: Text("Inserisci una carta di credito!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK")
                                      )
                                    ]
                                )
                        );
                      }
                      if(payment == paymentMethod.PayPal && widget.user.connectedAccount == false) {
                        canPurchase = false;
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                    content: Text("Account non connesso!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK")
                                      )
                                    ]
                                )
                        );
                      }
                      if(canPurchase) {
                        widget.user.purchases.add(widget.comic);
                        widget.comic.seller.sellings.add(widget.comic);
                        widget.comic.seller.comicsSale.remove(widget.comic);
                        SampleData.allComics.remove(widget.comic);

                        Navigator.pushNamed(context, '/', arguments: widget.user);
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