import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';

class ProfileView extends StatelessWidget {
  final String _title = "Profile";
  final String _latestOrder = "Geçmiş Siparişleriniz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: ProjectUtility.lightColorBoxDecoration,
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.primaryColor,
                    ),
                    Text("Hüseyin Sefa", style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      "hsefakcay@gmail.com",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      "+90 507 XXXX 25",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                _latestOrder,
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          )
        ],
      ),
    );
  }
}
