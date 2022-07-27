import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            Image(image: AssetImage("assets/images/empty_cart.png")),
            SizedBox(
              height: 10,
            ),
            Text(
              "No items found",
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
