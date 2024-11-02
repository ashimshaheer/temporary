import 'package:alabtechproject/app/modules/home/view_model/home_provider.dart';
import 'package:alabtechproject/app/modules/login/view_model/login_provider.dart';
import 'package:alabtechproject/app/utils/app_constants.dart';
import 'package:alabtechproject/app/utils/app_images.dart';
import 'package:alabtechproject/app/utils/common_widgets.dart';
import 'package:alabtechproject/app/utils/extentions.dart';
import 'package:alabtechproject/app/utils/size_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void modalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: Responsive.height * 35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CommonTextWidget(
                    color: Colors.white,
                    text: 'Thank you for adding a Tip!',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  SizeBoxV(Responsive.width * 2),
                  const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                  )
                ],
              ),
              SizeBoxH(Responsive.height * 1),
              Container(
                height: Responsive.height * 27,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(1, 1),
                          blurRadius: 1,
                          spreadRadius: 1,
                          blurStyle: BlurStyle.inner),
                    ]),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Consumer<HomeProvider>(builder: (context, obj, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizeBoxH(Responsive.height * 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Responsive.width * 55,
                            child: const CommonTextWidget(
                              color: Colors.grey,
                              text:
                                  'You made thier days! 100% of the tip will go to your delivery partners for this and future orders',
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              overFlow: TextOverflow.fade,
                              align: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: Responsive.width * 25, // Adjust width as per Responsive.width * 20
                            height: Responsive.height * 7.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), // Make it rounded
                              image: DecorationImage(
                                image: AssetImage(AppImages.deliveryImage), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 2),
                      SizedBox(
                        height: Responsive.height * 4,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  obj.tipIndexFnc(index: index);
                                },
                                child: Container(
                                  width: Responsive.width * 18.5,
                                  height: Responsive.height * 5,
                                  decoration: BoxDecoration(
                                    color:
                                        obj.tipIndex == index ? const Color.fromARGB(255, 250, 228, 213) : Colors.white,
                                    border: Border.all(
                                        color: obj.tipIndex == index ? const Color(0xFFFF6600) : Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          color: obj.tipIndex == index ? const Color(0xFFFF6600) : Colors.black,
                                          size: 18,
                                        ),
                                        CommonTextWidget(
                                          color: obj.tipIndex == index ? const Color(0xFFFF6600) : Colors.black,
                                          text: obj.tipList[index],
                                          fontWeight: FontWeight.w600,
                                        ),
                                        obj.tipIndex == index
                                            ? const Icon(
                                                Icons.error,
                                                color: Color(0xFFFF6600),
                                              )
                                            : const Text('')
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizeBoxV(Responsive.width * 3),
                            itemCount: 4),
                      ),
                      SizeBoxH(Responsive.height * 1.5),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      // SizeBoxH(Responsive.height * 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: obj.isCheckBox,
                            onChanged: (value) {
                              obj.isCheckBoxFnc();
                            },
                            activeColor: const Color(0xFFFF6600),
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: Responsive.width * 70,
                            child: const CommonTextWidget(
                              color: Colors.grey,
                              text: 'Add this tip autometically to future orders',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<HomeProvider>(builder: (context, obj, _) {
        return AlertDialog(
          title: const CommonTextWidget(
            color: Colors.black,
            text: 'Are you Sure?',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          content: const CommonTextWidget(
            color: Colors.black,
            text: 'you want logout this accound',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white, // OK button color
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Colors.black)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const CommonTextWidget(
                text: 'Cancel',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => obj.signOut(context: context),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF6600), // OK button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const CommonTextWidget(
                text: 'OK',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      });
    },
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Responsive.width * 100,
              height: Responsive.height * 22,
              decoration: const BoxDecoration(
                // color: Color(0xFFFF6600),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF6600), // Starting color
                    Color(0xFFFF8A00), // Lighter shade for gradient
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(40, 20),
                  bottomRight: Radius.elliptical(40, 20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  SizeBoxH(Responsive.height * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Responsive.width * 15, // Adjust width as per Responsive.width * 20
                            height: Responsive.height * 7.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50), // Make it rounded
                              image: DecorationImage(
                                image: AssetImage(AppImages.profileIMage), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget(
                                color: Colors.white,
                                text: 'Welcome ${context.read<LoginProvider>().username ?? 'user'}',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              CommonTextWidget(
                                color: Colors.white,
                                text: context.read<LoginProvider>().userEmail ?? '',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showConfirmationDialog(context);
                        },
                        child: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  SizeBoxH(Responsive.height * 1),
                  const SearchField()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: Responsive.height * 2),
              child: CommonTextWidget(
                color: Colors.grey[500] ?? Colors.grey,
                text: 'Top Restaurants',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      modalBottomSheet(context);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: Responsive.width * 38, // Adjust width as per Responsive.width * 20
                          height: Responsive.height * 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), // Make it rounded
                            image: DecorationImage(
                              image: AssetImage(AppImages.burgerImage), // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CommonTextWidget(
                                    color: Colors.white,
                                    text: 'FLAT DEAL',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.currency_rupee_sharp,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      CommonTextWidget(
                                        color: Colors.white,
                                        text: '125 OFF',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CommonTextWidget(
                                        color: Colors.grey[300] ?? Colors.grey,
                                        text: 'ABOVE ',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      Icon(
                                        Icons.currency_rupee_sharp,
                                        color: Colors.grey[300] ?? Colors.grey,
                                        size: 16,
                                      ),
                                      CommonTextWidget(
                                        color: Colors.grey[300] ?? Colors.grey,
                                        text: '199',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizeBoxV(Responsive.width * 5),
                        SizedBox(
                          height: Responsive.height * 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Responsive.width * 49,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                              const CommonTextWidget(
                                color: Colors.black,
                                text: 'Cake Trends',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              SizedBox(
                                width: Responsive.width * 45,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.green,
                                      child: Center(
                                          child: Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                    ),
                                    CommonTextWidget(
                                      color: Colors.black,
                                      text: '4.1(140)',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Colors.black,
                                    ),
                                    CommonTextWidget(
                                      color: Colors.black,
                                      text: '40-45 mins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              SizedBox(
                                width: Responsive.width * 45,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.purple,
                                      child: Center(
                                        child: Icon(
                                          Icons.local_mall,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    CommonTextWidget(
                                      color: Colors.black,
                                      text: 'Perfect Cake Delivery',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              SizedBox(
                                width: Responsive.width * 45,
                                child: const CommonTextWidget(
                                  color: Colors.grey,
                                  text: 'Bakery,cakes and pastrivessssss',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: Responsive.width * 28,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonTextWidget(
                                      color: Colors.grey,
                                      text: 'Padappai ',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 3,
                                    ),
                                    CommonTextWidget(
                                      color: Colors.grey,
                                      text: '3.km',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizeBoxH(Responsive.height * 4),
                itemCount: 5)
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 6, // Set the height of the container
      padding: const EdgeInsets.symmetric(horizontal: 16), // Optional padding
      decoration: BoxDecoration(
        color: Colors.white, // White background color
        borderRadius: BorderRadius.circular(16), // Optional rounded corners
      ),
      child: Center(
        child: TextField(
          controller: context.read<HomeProvider>().searchController,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(
            hintText: "Search", // Hint text
            border: InputBorder.none, // No border
          ),
          style: const TextStyle(
            fontSize: 16,
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
