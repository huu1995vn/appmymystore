import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xFFEFEDEE),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 10.0),
                  blurRadius: 10.0)
            ]),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 30.0,
              ),
            ),
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.79,
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'search car'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
