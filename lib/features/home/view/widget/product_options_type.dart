import 'package:flutter/material.dart';

class HorizontalOptionsScreen extends StatefulWidget {
  @override
  _HorizontalOptionsScreenState createState() => _HorizontalOptionsScreenState();
}

class _HorizontalOptionsScreenState extends State<HorizontalOptionsScreen> {
  List<Map<String, dynamic>> toppings = [
    {"name": "Cheese", "selected": true},
    {"name": "Olives", "selected": true},
    {"name": "Mushrooms", "selected": true},
    {"name": "Pepperoni", "selected": false},
  ];

  List<Map<String, dynamic>> sideOptions = [
    {"name": "French Fries", "selected": true},
    {"name": "Salad", "selected": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Toppings & Side Options")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Toppings",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 10,
                        children: toppings.map((item) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: item["selected"],
                              onChanged: (val) {
                                setState(() => item["selected"] = val!);
                              },
                            ),
                            Text(item["name"]),
                          ],
                        )).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Side Options",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 10,
                        children: sideOptions.map((item) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: item["selected"],
                              onChanged: (val) {
                                setState(() => item["selected"] = val!);
                              },
                            ),
                            Text(item["name"]),
                          ],
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var selectedToppings =
                toppings.where((e) => e["selected"]).map((e) => e["name"]).toList();
                var selectedSides =
                sideOptions.where((e) => e["selected"]).map((e) => e["name"]).toList();
                print("Selected Toppings: $selectedToppings");
                print("Selected Side Options: $selectedSides");
              },
              child: Text("Confirm Selection"),
            ),
          ],
        ),
      ),
    );
  }
}
