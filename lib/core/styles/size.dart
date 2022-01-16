import 'package:flutter/material.dart';

//Size Menyesuaikan Ukuran Lebar Layar
autoSizedWidth(BuildContext context, size){
  var sized = MediaQuery.of(context).size.width * size;
  return sized;
}

//Size Menyesuaikan Ukuran Tinggi Layar
autoSizedHeight(BuildContext context, size){
  var sized = MediaQuery.of(context).size.height * size;
  return sized;
}