import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/Model/cartModel.dart';
import 'package:shopping_project/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_project/dbhelper.dart';

class cartScreen extends StatefulWidget {
  const cartScreen({super.key});

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: const Text('Cart Screen'),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              child: const Icon(Icons.shopping_bag),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (!snapshot.hasData) {
                  return Text('text nhi aa rha hai');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    snapshot.data![index].image.toString(),
                                    height: 80,
                                    width: 80,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![index].productName
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                dbHelper.delete(
                                                    snapshot.data![index].id!);
                                                cart.removeCounter();
                                                cart.removeTotalPrice(
                                                    double.parse(snapshot
                                                        .data![index]
                                                        .productPrice
                                                        .toString()));
                                              },
                                              child: const Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${snapshot.data![index].unitTag.toString()} \t\$${snapshot.data![index].productPrice.toString()}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quaintity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initialPrice!;
                                                        if (quantity > 1) {
                                                          quantity--;
                                                          int? newPrice =
                                                              quantity * price;
                                                          dbHelper
                                                              .updateQuaintity(
                                                                  Cart(
                                                            id: snapshot
                                                                .data![index]
                                                                .id!,
                                                            productId: snapshot
                                                                .data![index]
                                                                .productId!,
                                                            productName: snapshot
                                                                .data![index]
                                                                .productName!,
                                                            initialPrice: snapshot
                                                                .data![index]
                                                                .initialPrice!,
                                                            productPrice:
                                                                newPrice,
                                                            quaintity: quantity,
                                                            unitTag: snapshot
                                                                .data![index]
                                                                .unitTag
                                                                .toString(),
                                                            image: snapshot
                                                                .data![index]
                                                                .image
                                                                .toString(),
                                                          ))
                                                              .then((value) {
                                                            cart.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!
                                                                    .toString()));
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            print(error);
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .quaintity
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quaintity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initialPrice!;
                                                        quantity++;
                                                        int? newPrice =
                                                            quantity * price;
                                                        dbHelper
                                                            .updateQuaintity(
                                                                Cart(
                                                          id: snapshot
                                                              .data![index].id!,
                                                          productId: snapshot
                                                              .data![index]
                                                              .productId!,
                                                          productName: snapshot
                                                              .data![index]
                                                              .productName!,
                                                          initialPrice: snapshot
                                                              .data![index]
                                                              .initialPrice!,
                                                          productPrice:
                                                              newPrice,
                                                          quaintity: quantity,
                                                          unitTag: snapshot
                                                              .data![index]
                                                              .unitTag
                                                              .toString(),
                                                          image: snapshot
                                                              .data![index]
                                                              .image
                                                              .toString(),
                                                        ))
                                                            .then((value) {
                                                          cart.addTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .initialPrice!
                                                                  .toString()));
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print(error);
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) != '0.00',
              child: Column(
                children: [
                  ReuseAblewidge(
                    titleName: 'Total Price',
                    itemvalue: r"$" + value.getTotalPrice().toStringAsFixed(2),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ReuseAblewidge extends StatelessWidget {
  final String titleName, itemvalue;
  const ReuseAblewidge({required this.titleName, required this.itemvalue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            itemvalue,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
