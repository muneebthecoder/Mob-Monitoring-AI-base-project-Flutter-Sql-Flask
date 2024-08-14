import 'package:flutter/material.dart';

dynamic userInfo;

Container MyTextFormWithIcon(
    {required TextEditingController controller,
    required String hintText,
    required String labelText,
    required Icon icon,
    keyboardType,
    bool readonly = false,
    dynamic onchnage}) {
  return Container(
    height: 55.0,
    width: 300,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 235, 238, 239),
      borderRadius: BorderRadius.circular(10),
      //     border: Border.all(color: Colors.black)
    ),
    child: Center(
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(child: icon),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 240,
            child: TextFormField(
              style: TextStyle(fontSize: 14),
              onChanged: onchnage,
              readOnly: readonly,
              controller: controller,
              keyboardType: keyboardType,
              cursorColor: Color.fromARGB(255, 60, 59, 59),
              decoration: InputDecoration(
                  hintText: hintText,
                  labelText: labelText,
                  border: InputBorder.none,
                  focusColor: Color.fromARGB(255, 60, 59, 59),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  labelStyle: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    ),
  );
}

Container MyTextFormWithIC(
    {required TextEditingController controller,
    required String hintText,
    required String labelText,
    required Icon icon,
    keyboardType,
    bool readonly = false,
    required void Function() onTap}) {
  return Container(
    height: 55.0,
    width: 300,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 235, 238, 239),
      borderRadius: BorderRadius.circular(10),
      //    border: Border.all(color: Colors.black)
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
          width: 210.0,
          child: TextFormField(
            style: TextStyle(fontSize: 14),
            readOnly: readonly,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                border: InputBorder.none,
                focusColor: Colors.black,
                contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                labelStyle: TextStyle(color: Colors.black)),
          ),
        ),
        GestureDetector(
          child: Container(
            child: icon,
          ),
          onTap: onTap,
        ),
      ],
    ),
  );
}

Container MyTextForm({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  keyboardType,
  bool readonly = false,
}) {
  return Container(
    height: 55.0,
    width: 300,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 235, 238, 239),
      borderRadius: BorderRadius.circular(10),
      //       border: Border.all(color: Colors.black)
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
          width: 240,
          child: TextFormField(style: TextStyle(fontSize: 14),
            readOnly: readonly,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                border: InputBorder.none,
                focusColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
      ],
    ),
  );
}

InkWell MyLinklabel(
    {required String text, required Function() onTap, Color? color}) {
  return InkWell(
    onTap: onTap,
    child: Text(
      text,
      style: TextStyle(
          color: color == null ? Color.fromARGB(255, 58, 181, 247) : color,
          fontSize: 13),
    ),
  );
}

InkWell MyButton({required String text, required Function() onTap}) {
  return InkWell(
      child: Container(
          height: 30,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    //    fontWeight: FontWeight.bold
                  )))),
      onTap: onTap);
}

Container MySearchTextForm({
  required TextEditingController controller,
  required String hintText,
  keyboardType,
  bool readonly = false,
}) {
  return Container(
    height: 40,
    width: 300,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)),
    child: Center(
      child: Row(
        children: [
          Container(child: Icon(Icons.search_outlined)),
          Container(
            width: 240,
            child: TextFormField(
              readOnly: readonly,
              controller: controller,
              keyboardType: keyboardType,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  focusColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    ),
  );
}

InkWell MyButton2(
    {required String text,
    required Function() onTap,
    required Color textColor,
    required Color bgColor}) {
  return InkWell(
      child: Container(
          height: 35.0,
          width: 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: bgColor),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                        fontWeight: FontWeight.w400
                  )))),
      onTap: onTap);
}

InkWell MyButton3(
    {required String text,
    required Function() onTap,
    required Color textColor,
    required Color bgColor}) {
  return InkWell(
      child: Container(
          height: 40.0,
          width: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: bgColor),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                        fontWeight: FontWeight.w500
                  )))),
      onTap: onTap);
}

InkWell SeeAllLable(
    {required String text, required Function() onTap, Color? color}) {
  return InkWell(
    onTap: onTap,
    child: Text(
      text,
      style: TextStyle(
          color: color == null ? Color.fromARGB(255, 0, 0, 0) : color,
          fontSize: 14,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget MyMenuButton({
  required String text,
  required Icon icon,
  required Function() press,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: EdgeInsets.zero, // Set padding to zero here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color(0xFFF5F6F9),
      ),
      onPressed: press,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), // Add padding to the icon
            child: icon,
          ),
          const SizedBox(width: 20),
          Expanded(child: Text(text)),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
