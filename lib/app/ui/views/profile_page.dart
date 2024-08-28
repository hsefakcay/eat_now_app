import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.primaryLightColor,
              ),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.primaryColor,
                    ),
                    Text(
                      "Hüseyin Sefa",
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "hsefakcay@gmail.com",
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "+90 507 XXXX 25",
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                "Geçmiş Siparişleriniz",
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 18,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
