import 'package:flutter/material.dart';

class ManageN extends StatelessWidget {
  const ManageN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset("images/1.gif", height: 50, width: 50),
          Form(
              child: TextFormField(
            decoration: InputDecoration(hintText: 'Note Title'),
          )),
          TextField(
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Note here')),
          Center(child: Icon(Icons.add_box_rounded, size: 50)),
        ],
      ),
      height: 500,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
    );
  }
}
