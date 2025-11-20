import 'dart:async';

import 'package:animal_kart_demo2/providers/cart_provider.dart';
import 'package:animal_kart_demo2/screens/tabs_screens/cart_screen.dart';
import 'package:animal_kart_demo2/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/buffalo.dart';

class BuffaloDetailsScreen extends ConsumerStatefulWidget {
  final Buffalo buffalo;

  const BuffaloDetailsScreen({super.key, required this.buffalo});

  @override
  ConsumerState<BuffaloDetailsScreen> createState() =>
      _BuffaloDetailsScreenState();
}

class _BuffaloDetailsScreenState
    extends ConsumerState<BuffaloDetailsScreen> {
  int qty = 1;

  late List<String> imageList;

  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Buffalo + sample images
    imageList = [
      widget.buffalo.image,
      "assets/images/murrah_3.jpeg",
      "assets/images/murrah_5.jpeg",
    ];

    _pageController = PageController();

    // Auto-slide
    Future.delayed(const Duration(seconds: 3), autoScroll);
  }

  // ---------------------- Auto Scroll ----------------------
  void autoScroll() {
    if (!mounted) return;

    int nextPage = currentIndex + 1;

    if (nextPage == imageList.length) nextPage = 0;

    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 3), autoScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------
  //                       UI START
  // -----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final buffalo = widget.buffalo;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Buffalo Details",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 8),

          // ---------------------- IMAGE CAROUSEL ----------------------
          SizedBox(
            height: 260,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: imageList.length,
                  onPageChanged: (index) =>
                      setState(() => currentIndex = index),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          imageList[index],
                          width: MediaQuery.of(context).size.width * 0.85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),

                // ---------------- DOT INDICATORS ----------------
                Positioned(
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      imageList.length,
                      (index) => AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4),
                        height: 8,
                        width: currentIndex == index ? 22 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.white
                              : Colors.white54,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ---------------------- DETAILS SECTION ----------------------
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      buffalo.breed,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      "${buffalo.milkYield} L/day • Insurance ₹${buffalo.insurance}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      buffalo.description,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---------------------- BOTTOM PANEL ----------------------
          Container(
            padding:
                const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Row(
              children: [
                // QTY •••••••••••••••••••••••••••••••••••••••••
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FDF8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      _qtyButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (qty > 1) {
                            setState(() => qty--);
                          }
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 12),
                        child: Text(
                          "$qty",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _qtyButton(
                        icon: Icons.add,
                        onTap: () =>
                            setState(() => qty++),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // ADD TO CART BUTTON
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .setItem(buffalo.id, qty, buffalo.insurance);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CartScreen(showAppBar: true),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryGreen,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "₹${buffalo.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------- QTY BUTTON ----------------------
  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
