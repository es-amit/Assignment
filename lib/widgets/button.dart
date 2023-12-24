import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  const CustomButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
         
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width,
        child: const Card(
          margin: EdgeInsets.only(left: 25),
          elevation: 6.0,
          clipBehavior: Clip.hardEdge,
          child: Center(
            child: Icon(Icons.add,),
          ),
        ),
      ),
    );
  }
}