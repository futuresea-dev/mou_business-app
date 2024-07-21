//import 'package:flutter/material.dart';
// class TextAnim{
//   static const String GestureDetector(
//   onTap: () {
//   setState(() {
//   _isTypeCompleted = false;
//   if(_titleLength == 0){
//   _isTypeCompleted = true;
//   }
//   });
//   },
//   child: TextFormField(
//   maxLength: _isTypeOne ? 55 : 30,
//   controller: _titleController,
//   decoration: InputDecoration(
//   counterText: "",
//   hintText: 'To do title',
//   hintStyle: const TextStyle(
//   color: Constants.primaryLightGrayHint,
//   fontSize: 16,
//   fontWeight: FontWeight.normal,
//   ),
//   border: OutlineInputBorder(
//   borderSide: BorderSide.none,
//   borderRadius: BorderRadius.circular(12),
//   ),
//   suffix: SizedBox(
//   width: 18,
//   child: Align(
//   alignment: Alignment.topRight,
//   child: Text(
//   _isTypeOne
//   ? '${55 - _titleLength}'
//       : '${30 - _titleLength}',
//   style: const TextStyle(
//   fontSize: 14,
//   fontWeight: FontWeight.normal,
//   color: Constants.lightGraySecondaryText,
//   ),
//   ),
//   ),
//   ),
//   prefixIcon: Padding(
//   padding: const EdgeInsets.only(right: 18.0, left: 12),
//   child: Visibility(
//   visible: !_isTypeCompleted,
//   replacement: Container(
// // height: 20,
//   width: 40,
//   child: Image.asset(
//   'assets/icons/event.png',
// //fit: BoxFit.fitHeight,
//   ),
//   ),
//   child: Padding(
//   padding: const EdgeInsets.only(left:0.0),
//   child: SizedBox(
// // height: 40,
//   width:40,
//   child: Lottie.asset('assets/anim/finalevent.json',
// // height: 50,
// //width: 4,
// // fit: BoxFit.fitWidth,
//   repeat: false),
//   ),
//   ),
//   ),
//   ),
//   ),
//   style: const TextStyle(
//   color: Constants.grayPrimaryText,
//   fontWeight: FontWeight.bold,
//   fontFamily: Constants.customFontFamily,
//   ),
//   validator: (value) {
//   if (value == null || value.isEmpty) {
//   return 'Please enter a title';
//   }
//   return null;
//   },
//
// // onSaved: (value) {
// //   if(_isTypeOne){
// //   _todo = value!;
// // }
// // _listTodo= value!;
// // },
//   onEditingComplete: () {
//   setState(() {
//   if(_titleLength !=0) {
//   _isTypeCompleted = false;
//   }else if(_titleLength == 0){
//   _isTypeCompleted = true;
//   }
//   });
//   },
//
//   ),
//   ),
// }
