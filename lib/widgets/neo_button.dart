import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/common/utils.dart';
import 'package:get/get.dart';

class NeoButton extends StatelessWidget {


   NeoButton({
    super.key,
  });
  var color = Colors.red;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.red.shade300,
                  offset: const Offset(4.0,4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0
              ),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0,-4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0
              )
            ]
        ),
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}