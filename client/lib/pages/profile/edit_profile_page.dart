import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    _usernameController.text = userProvider.user.username;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GFIconButton(
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            type: GFButtonType.transparent,
          ),
          centerTitle: true,
          title: const Text(
            'Chỉnh sửa thông tin',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Implement avatar editing functionality
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userProvider.user.avatar),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Tên người dùng',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                focusColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            GFButton(
              onPressed: () {
                final newUsername = _usernameController.text;
                Provider.of<UserProvider>(context, listen: false)
                    .setUsername(newUsername);
                UsersApi.updateUsername(context, newUsername);
                Provider.of<NavigatorProvider>(context, listen: false)
                    .setShow(true);
                Navigator.of(context).pop();
              },
              text: "Cập nhật",
              type: GFButtonType.solid,
              size: GFSize.LARGE,
              fullWidthButton: true,
              color: Utils.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
