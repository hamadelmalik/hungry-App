import 'package:flutter/material.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
class OptionView extends StatefulWidget {
  const OptionView({super.key});

  @override
  State<OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView> {
  bool isOptionsLoading = false;
  final String baseUrl = "http://192.168.1.19:8000/storage/uploadimages/";

  ProductRepo productRepo=ProductRepo();
  List<dynamic> options = [];
@override
  void initState() {
  getNewOptions();
    super.initState();
  }
  Future<void>getNewOptions ()async{
    setState(() {
      isOptionsLoading = true;
    });
    final res = await productRepo.getNewOption();
  setState(() {
    options=res;
    isOptionsLoading = false;
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 👈 خلفية بيضاء
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/product1.png',height: 100,width: 100,),

          Expanded(
            child: isOptionsLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final item = options[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Group name
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 2),

                        // Options list (عرض فقط)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: item.options.map<Widget>((opt) {
                            return Container(
                              width: 90,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Ingredient image (placeholder)
                                  Container(
                                    height: 50,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          Uri.encodeFull(
                                            "http://192.168.1.19:8000/storage/${opt.image}",
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),


                                  ),

                                  const SizedBox(height: 6),

                                  // Name
                                  Text(
                                    opt.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  // Add button
                                  Container(
                                    height: 26,
                                    width: 26,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.check_box, color: Colors.white, size: 18),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}