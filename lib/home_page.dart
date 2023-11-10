import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdlibrary_a_0613/invoice/model/product.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';
import 'package:gdlibrary_a_0613/pdf_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String id = const Uuid().v1();
  File? image;
  
}

List<Product>products = [
    Product("membership", 50000),
    Product("Books", 30000),
    Product("Pen", 5000),
    Product("Shacks", 10000),
    Product("Hambuger",25000),
  ];
  int number = 0;
  getTotal() => products
    .fold(0.0, 
      (double prev, element) => prev + (element.price * element.amount))
    .toStringAsFixed(2);
  
  getPPN() => products
    .fold(
      0.0, 
      (double prev, element) => 
        prev + 
        (element.price /100 * element.ppnInPercent * element.amount))
    .toStringAsFixed(2);

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e){
      debugPrint(
        'Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker(). pickImage(source: ImageSource.camera);

      if(image == null) return;
      final imageTemp = File(image.path);
    } on PlatformException catch (e){
      debugPrint(
        'Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(context),
      body: inputSection(context),
    )
  }

  AppBar appBar(BuildContext context){
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        'Modul 8 Library'
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17.sp,
          fontWeight: FontWeight.bold),
        ), 
    );
  }

  SingleChildScrollView inputSection(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inputPersonalData(),
          SizedBox(height: 5.h),
          Center(
            child: Text(
              'Buy Product',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          inputProduct(),
          buttomCreatePDF(context)
        ],
      ),
    );
  }

  Container inputPersonalData() {
    return Container(
      margin: EdgeInsets.all(3.h),
      child: ,
    )
  }

Container inputPersonalData(){
    return Container(
      margin: EdgeInsets.all(3.h),
      child: Column(children: [
        Center(
          child: Text(
            'Fill This Form'
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment
          .center,
        children: [
          Padding(
            EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
          child: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          onPreseed: () {
            pickImage(){
              pickImageC();
            },
            child: const Text("Pick Image form Camera"),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
            child:ElevatedButton(
             fontStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
             ) 
            ),
            onPreseed() {
              pickImage();
            },
            child: const Text("Pick Image From Gallery"),
            ),
          ),
          SizedBox(
            width: 10.w),
      ],
    ),
    SizedBox(
      height: 2.h,
      

