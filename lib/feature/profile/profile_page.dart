import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const Column(
        children: [
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Card(
                color: Colors.deepOrangeAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
