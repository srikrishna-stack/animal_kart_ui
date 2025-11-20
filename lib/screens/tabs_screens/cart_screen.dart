import 'package:animal_kart_demo2/providers/buffalo_provider.dart';
import 'package:animal_kart_demo2/providers/cart_provider.dart';
import 'package:animal_kart_demo2/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  final bool showAppBar;
  const CartScreen({super.key, this.showAppBar = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final buffaloList = ref.watch(buffaloListProvider);

    final items = buffaloList.where((b) => cart.containsKey(b.id)).toList();

    if (items.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("Your cart is empty"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      // ---------- APP BAR ----------
      appBar: showAppBar
          ? AppBar(
              elevation: 0,
              toolbarHeight: 40,
               leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
              title: const Text(
                "Cart",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            )
          : null,

      // ---------- BOTTOM BUTTON ----------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text(
              "Proceed to Payment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),

      // ---------- MAIN LIST ----------
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: items.map((buff) {
          final item = cart[buff.id]!;
          final qty = item.qty;

          final price = buff.price * qty;
          final insurance = item.insurancePaid;

          return Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        buff.image,
                        width: 110,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buff.breed,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text("Age: 3 yrs",
                              style: TextStyle(color: Colors.grey.shade700)),
                          Text("Quantity: $qty",
                              style: TextStyle(color: Colors.grey.shade700)),
                          Text("Milk Yield: ${buff.milkYield} L/day",
                              style: TextStyle(color: Colors.grey.shade700)),
                              SizedBox(height: 10,),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5F2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // MINUS
                        GestureDetector(
                          onTap: () => ref
                              .read(cartProvider.notifier)
                              .decrease(buff.id),
                          child: const Icon(Icons.remove,
                              size: 24, color: Colors.black),
                        ),

                        const SizedBox(width: 22),

                        // QTY TEXT
                        Text(
                          "$qty",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(width: 22),

                        // PLUS
                        GestureDetector(
                          onTap: () => ref
                              .read(cartProvider.notifier)
                              .increase(buff.id),
                          child: const Icon(Icons.add,
                              size: 24, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),


                        ],
                        
                      ),
                    ),

                    // DELETE
                    GestureDetector(
                      onTap: () =>
                          ref.read(cartProvider.notifier).remove(buff.id),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

               

                const SizedBox(height: 20),

                // ---------- INFO BOX ----------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5FDEB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "What happens next?\n"
                    "✓ 12-day quarantine period begins\n"
                    "✓ Daily health monitoring updates\n"
                    "✓ Replacement guarantee if issues found\n"
                    "✓ GPS-tracked safe transport\n"
                    "✓ Complete documentation provided",
                    style: TextStyle(
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---------- PRICE BREAKDOWN ----------
                const Text(
                  "Price Breakdown",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                _priceRow("Price:", "₹${price.toString()}"),
                const SizedBox(height: 4),
                _priceRow("Insurance:", "₹${insurance.toString()}"),

                const Divider(height: 28),

                _priceRow("Sub Total", "₹${(price + insurance)}",
                    isBold: true),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 19 : 15,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
