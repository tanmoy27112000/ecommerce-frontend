import 'package:flutter/material.dart';

class EcomScreen extends StatefulWidget {
  const EcomScreen({super.key});

  @override
  State<EcomScreen> createState() => _EcomScreenState();
}

class _EcomScreenState extends State<EcomScreen> {
  Map<String, int> cart = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          double total = 0;
          final keys = cart.keys.toList();
          for (var i = 0; i < keys.length; i++) {
            total += cart[keys[i]]! * 10 * (i + 1);
          }
          print(total);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.shopping_bag,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Ecommerce',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (cart.containsKey('Product ${index + 1}')) {
                      cart['Product ${index + 1}'] = cart['Product ${index + 1}']! + 1;
                    } else {
                      cart['Product ${index + 1}'] = 1;
                    }
                  });
                },
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            radius: 60,
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Product ${index + 1}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
                child: Text(
                  cart['Product ${index + 1}']?.toString() ?? '0',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
