import 'package:animal_kart_demo2/widgets/bufflo_details_screen.dart';
import 'package:animal_kart_demo2/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/buffalo.dart';


class BuffaloCard extends ConsumerWidget {
  final Buffalo buffalo;

  const BuffaloCard({super.key, required this.buffalo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disabled = !buffalo.inStock;

    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BuffaloDetailsScreen(buffalo: buffalo),
                ),
              );
            },
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: kCardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.06),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.asset(
                      buffalo.image,
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: buffalo.inStock
                            ? Colors.white
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        buffalo.inStock ? "Available" : "Out of Stock",
                        style: TextStyle(
                          color: buffalo.inStock ? kPrimaryGreen : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: 
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LEFT SIDE: Breed + Milk Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  buffalo.breed,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827), // dark text
                                  ),
                                ),
                                const SizedBox(height: 6),

                                Row(
                                  children: [
                                    const Icon(Icons.local_drink, size: 18, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${buffalo.milkYield}L/day",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          // RIGHT SIDE: Insurance Button
                          OutlinedButton.icon(
                            onPressed: () => _showInsuranceInfo(context),
                            icon: const Icon(Icons.info_outline, size: 18, color: Colors.black),
                            label: const Text(
                              "Insurance Details",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFF9FAFB), // light background like design
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: BorderSide.none, // No border – matches your UI
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 5),
                    const Divider(
                        color: Colors.greenAccent,      // light grey line
                        thickness: 0.3,            // thin line
                        height: 10,              // spacing above & below
                      ),
                      const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "₹${buffalo.price.toString()}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: disabled
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          BuffaloDetailsScreen(buffalo: buffalo),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 14),
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInsuranceInfo(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// --- TOP DRAG HANDLE ---
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 14),

            /// --- TITLE + CLOSE BUTTON ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Insurance Offer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// --- INSURANCE TABLE ---
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF10B981), width: 1),
              ),
              child: Column(
                children: [
                  /// HEADER ROW
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFF7ED),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            "S.No",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Insurance",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ROW 1 — highlighted
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    color: const Color(0xFF10B981),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text("1",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                        Expanded(
                          child: Text("₹150,000",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                        Expanded(
                          child: Text(
                            "₹13,000",
                            textAlign: TextAlign.right,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ROW 2
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4FFFA),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(18)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text("2", style: TextStyle(fontSize: 14)),
                        ),
                        Expanded(
                          child: Text("₹150,000",
                              style: TextStyle(fontSize: 14)),
                        ),
                        Expanded(
                          child: Text(
                            "Free",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// --- NOTE BOX ---
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEFFFF7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Note:\n"
                "If you purchase 2 Murrah buffaloes you will "
                "receive insurance for the second buffalo completely Free",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 25),

         
            

            const SizedBox(height: 18),
          ],
        ),
      );
    },
  );
}

}
