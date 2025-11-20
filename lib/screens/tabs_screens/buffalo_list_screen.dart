import 'package:animal_kart_demo2/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/buffalo_provider.dart';
import '../../widgets/buffalo_card.dart';

class BuffaloListScreen extends ConsumerWidget {
  const BuffaloListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buffalos = ref.watch(buffaloListProvider);

    return Container(
      color: kScreenBg,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 90, top: 12),
        itemCount: buffalos.length,
        itemBuilder: (context, i) => BuffaloCard(buffalo: buffalos[i]),
      ),
    );
  }
}
