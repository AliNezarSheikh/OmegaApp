import 'package:flutter/material.dart';
import 'package:omega/Constant/Components.dart';

import '../../Constant/reusable.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Row(

              children: [
                buildeditButton(context: context, name: "Edit"),
                Spacer(),
                buildsignoutButton(context: context, name: "Signout"),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            buildHeader(),
            SizedBox(height: 20,),
            buildinfo(),
          ],
        ),
      ),
    );
  }
}
