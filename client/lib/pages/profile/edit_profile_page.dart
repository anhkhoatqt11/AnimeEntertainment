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
        backgroundColor: const Color(0xFF141414),
        title: Text('Chỉnh sửa thông tin'),
      ),
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
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Tên người dùng',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement username update functionality
                final newUsername = _usernameController.text;
                // Update the username using userProvider.updateUsername(newUsername);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
