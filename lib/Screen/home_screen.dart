import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shopping_project/Model/cartModel.dart';
import 'package:shopping_project/cart_provider.dart';
import 'package:shopping_project/dbhelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? database = DBHelper();
  List<String> productName = [
    'Mango',
    'Orange',
    'Peach',
    'Graps',
    'Banana',
    'Apple',
    'Watermelon',
    'Cherry',
    'Mix fruit'
  ];
  List<String> productUnit = [
    'KG',
    'KG',
    'KG',
    'KG',
    'Drazen',
    'KG',
    'KG',
    'KG',
    'KG'
  ];
  List<int> productPrice = [120, 200, 120, 120, 150, 45, 40, 250, 300];
  List<String> productImage = [
    'https://www.bing.com/th?id=OIP.pMHUYSbHuObbdML7NBkdMQHaFG&w=226&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2',
    'https://www.bing.com/th?id=OIP.hOr6_I_hlrEyTS_vK4_ccgAAAA&w=246&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OSK.mmcolQ2_Qi7Vz_ZJmE1uWuhdNvXSgX3b7Ekwlu3EyYZbwf_A&w=130&h=100&c=8&o=6&dpr=1.5&pid=SANGAM',
    'https://th.bing.com/th?id=OSK.HERO_BMgrDLRe-hOhNZkoE_V4HPTLfAorLZGYxgJB6KweZo&w=312&h=200&c=15&rs=2&o=6&dpr=1.5&pid=SANGAM',
    'https://th.bing.com/th?id=OSK.HEROlQwq-MqJurmEPVYmkdCbw0m3cgZM0brBFvz8RHzaL00&w=312&h=200&c=15&rs=2&o=6&dpr=1.5&pid=SANGAM',
    'https://www.bing.com/th?id=OIP.6yHdb5-e5s7VQKjdsBjBNgHaHd&w=178&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OIP.LWpbafIZesG55wkPX5OqswHaEQ&w=218&h=125&rs=1&p=0&o=6&dpr=1.5&pid=Stories',
    'https://www.bing.com/th?id=OIP.woZa0T7Lob5bEkiLvzu0AQHaE8&w=231&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2',
    'https://www.bing.com/th?id=OIP.c6Tbz7IbCn9bVXzXQSOqhgHaFN&w=213&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2'
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          title: const Text('Product List'),
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
            SizedBox(width: MediaQuery.of(context).size.width * 0.04)
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productName.length,
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
                                productImage[index],
                                height: 80,
                                width: 80,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      productName[index],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${productUnit[index]} \t\$${productPrice[index]}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          database!
                                              .insert(Cart(
                                            id: index,
                                            productId: index.toString(),
                                            productName: productName[index],
                                            initialPrice: productPrice[index],
                                            productPrice: productPrice[index],
                                            quaintity: 1,
                                            unitTag: productUnit[index],
                                            image: productImage[index],
                                          ))
                                              .then((value) {
                                            cart.addTotalPrice(
                                                productPrice[index].toDouble());
                                            cart.addCounter();
                                            print(
                                                'Data successfully added to the database');
                                          }).catchError((error) {
                                            print('Error: $error');
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Add to cart',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
