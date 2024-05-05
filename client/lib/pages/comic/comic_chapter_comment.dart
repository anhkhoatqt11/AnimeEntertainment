import 'package:flutter/material.dart';
import 'package:comment_tree/comment_tree.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterComment extends StatelessWidget {
  final String comicId;
  final int chapterIndex;

  const ComicChapterComment(
      {super.key, required this.comicId, required this.chapterIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text("Bình luận"),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF141414)),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ListView(
            children: [
              CommentTreeWidget<Comment, Comment>(
                Comment(
                    avatar: 'null',
                    userName: 'hoaihai1',
                    content: 'felangel made felangel/cubit_and_beyond public '),
                [
                  Comment(
                      avatar: 'null',
                      userName: 'hai2',
                      content: 'A Dart template generator which helps teams'),
                ],
                treeThemeData:
                    TreeThemeData(lineColor: Color(0xFF141414), lineWidth: 3),
                avatarRoot: (context, data) => PreferredSize(
                  preferredSize: Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                avatarChild: (context, data) => PreferredSize(
                  preferredSize: Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                contentChild: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text('Like'),
                              SizedBox(
                                width: 24,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                contentRoot: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text('Like'),
                              SizedBox(
                                width: 24,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              CommentTreeWidget<Comment, Comment>(
                Comment(
                    avatar: 'null', userName: 'hoaihai2', content: 'so good'),
                [
                  Comment(
                      avatar: 'null',
                      userName: 'hoaihai4',
                      content: 'A Dart template generator which helps teams'),
                  Comment(
                      avatar: 'null',
                      userName: 'hoaihai',
                      content:
                          'A Dart template generator which helps teams generator which helps teams '),
                ],
                treeThemeData:
                    TreeThemeData(lineColor: Color(0xFF141414), lineWidth: 3),
                avatarRoot: (context, data) => PreferredSize(
                  preferredSize: Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                avatarChild: (context, data) => PreferredSize(
                  preferredSize: Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                contentChild: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text('Like'),
                              SizedBox(
                                width: 24,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                contentRoot: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text('Like'),
                              SizedBox(
                                width: 24,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }
}
