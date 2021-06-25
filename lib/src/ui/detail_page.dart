// import 'package:flutter/material.dart';

// class DetailPage extends StatefulWidget {
//   const DetailPage({Key key}) : super(key: key);

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     final todoItem = ModalRoute.of(context)?.settings?.arguments;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: Spacing.s, right: Spacing.s),
//           child: Form(
//             key: _key,
//             child: Column(
//               children: [
//                 DefaultTextField2Line(
//                   title: "หัวข้อ",
//                   controller: _edtTitleController,
//                   requires: _fieldRequired,
//                   validator: _fieldRequired ? Validator.isEmptyValidator : null,
//                 ),
//                 DefaultTextField2Line(
//                   title: "รายละเอียด",
//                   requires: _fieldRequired,
//                   controller: _edtSubtitleController,
//                   validator: _fieldRequired ? Validator.isEmptyValidator : null,
//                   maxLine: 5,
//                 ),
//                 DefaultTextField2Line(
//                   focusNode: AlwaysDisabledFocusNode(),
//                   title: "StartAt",
//                   controller: _edtStartAtController,
//                   onTap: () {
//                     _selectDate(
//                       edt: _edtStartAtController,
//                     );
//                   },
//                 ),
//                 DefaultTextField2Line(
//                   focusNode: AlwaysDisabledFocusNode(),
//                   title: "EndAt",
//                   controller: _edtEndAtController,
//                   onTap: () {
//                     _selectDate(
//                       edt: _edtEndAtController,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
