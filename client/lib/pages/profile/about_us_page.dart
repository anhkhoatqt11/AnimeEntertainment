import 'package:anime_and_comic_entertainment/pages/profile/about_us_privacy.dart';
import 'package:anime_and_comic_entertainment/pages/profile/about_us_tou.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          backgroundColor: const Color(0xFF141414),
          elevation: 0,
          leading: GFIconButton(
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Provider.of<NavigatorProvider>(context, listen: false)
                  .setShow(true);
              Navigator.of(context).pop();
            },
            type: GFButtonType.transparent,
          ),
          centerTitle: true,
          title: const Center(
            child: Text(
              "Về chúng tôi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Về ứng dụng",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 24),
                      const Text('Phiên bản 0.1b',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                      const Text(
                          'Copyright ©️ 2024 Skylark. Ltd. Bảo lưu mọi quyền.',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                      SizedBox(height: 24),
                      const Text("Về công ty",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 24),
                      const Text('Skylark. Ltd.',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                      const Text(
                          'Địa chỉ: Đường Hàn Thuyên, Khu phố 6, P.Thủ Đức, Thành phố Hồ Chí Minh.',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                      SizedBox(height: 48),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => AboutUsToU())))
                        },
                        child: Text('Điều khoản sử dụng',
                            style: TextStyle(
                                color: Utils.primaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline)),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => AboutUsPrivacy())))
                        },
                        child: Text('Chính sách quyền riêng tư',
                            style: TextStyle(
                                color: Utils.primaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline)),
                      ),
                    ]))));
  }
}
