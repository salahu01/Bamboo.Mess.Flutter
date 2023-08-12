import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/bluetooth_connection/bloc/bluethooth_connection_cubit.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({super.key});

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

String dropdownvalue = 'Select Employee';

var employeename = [
  'Select Employee',
  'Employee 1',
  'Employee 2',
  'Employee 3',
  'Employee 4',
  'Employee 5',
];

String dropdownvalues = "Dine in";

var paymentmethod = [
  'Dine in',
  'Parcel',
];

class _ChargeScreenState extends State<ChargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: primary.value,
        systemOverlayStyle:
            SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
        leadingWidth: 120,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(
                  bottom: 24, left: 12, right: 24, top: 24),
              elevation: 4,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text(
                      'Billing',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
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
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.6),
                          ),
                          subtitle: Text(
                            'Qty : $i',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.6),
                          ),
                          trailing: Text(
                            '\$ ${i}00',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.6),
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
                    'Total Amount : 100',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: const Color.fromARGB(255, 228, 222, 222),
              child: Column(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "100.00",
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Total amount due",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: DropdownButton(
                                  value: dropdownvalue,
                                  underline: const SizedBox.shrink(),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Icon(Icons.keyboard_arrow_down,
                                        size: 35),
                                  ),
                                  items: employeename.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.height * 0.07,
                              // color: Colors.amber,
                              child: Center(
                                child: DropdownButton(
                                  underline: const SizedBox.shrink(),
                                  value: dropdownvalues,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Icon(Icons.keyboard_arrow_down,
                                        size: 35),
                                  ),
                                  items: paymentmethod.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalues = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 45),
                        InkWell(
                          onTap: () async {
                            BlocProvider.of<PrinterConnectivityCubit>(context)
                                .printerBluetoothManager
                                .printTicket(await BlocProvider.of<
                                        PrinterConnectivityCubit>(context)
                                    .generateBtPrint());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                color: primary.value,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                              child: Text(
                                "Charge Amount",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
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
