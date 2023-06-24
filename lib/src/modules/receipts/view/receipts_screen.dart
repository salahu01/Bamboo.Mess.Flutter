import 'package:flutter/material.dart';

class ReceiptsView extends StatefulWidget {
  const ReceiptsView({super.key});

  @override
  State<ReceiptsView> createState() => _ReceiptsViewState();
}

class _ReceiptsViewState extends State<ReceiptsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Flexible(
            child: Card(
              elevation: 4,
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
              ),
            ),
          ),
          Flexible(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 128, vertical: 24),
              elevation: 4,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text(
                      'Billing',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, left: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Billed : Employee 1',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 128, vertical: 8),
                    child: Divider(color: Colors.black),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        i += 1;
                        return ListTile(
                          dense: true,
                          title: const Text(
                            'Pani puri ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                          subtitle: Text(
                            'Qty : $i',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                          trailing: Text(
                            '\$ ${i}00',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: Colors.black),
                  ),
                  const Text(
                    'Total : 100.00',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700, letterSpacing: 0.6),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
