import 'package:anime_and_comic_entertainment/model/comment.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterComment extends StatefulWidget {
  final String chapterId;

  const ComicChapterComment({super.key, required this.chapterId});

  @override
  State<ComicChapterComment> createState() => _ComicChapterCommentState();
}

class _ComicChapterCommentState extends State<ComicChapterComment> {
  String commentReplied = '';
  late List<Comments> comments = [];
  late List<CommentTreeWidget> cmtTreeWidge = [];
  Future<List<Comments>> getComicChapterComments() async {
    var result =
        await ComicsApi.getComicChapterComments(context, widget.chapterId);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getComicChapterComments().then((value) => setState(() {
          comments = value;

          loadComments();
        }));
  }

  void loadComments() {
    setState(() {
      comments.clear();

      for (var comment in comments) {
        List<Comment> replies = [];
        comment.replies!.forEach((element) {
          replies.add(Comment(
              avatar: element['avatar'],
              userName: element['userName'],
              content: element['content']));
        });

        cmtTreeWidge.add(CommentTreeWidget(
          Comment(
              avatar: comment.avatar,
              userName: comment.userName,
              content: comment.content),
          replies,
          treeThemeData:
              TreeThemeData(lineColor: Color(0xFF141414), lineWidth: 3),
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(data.avatar),
            ),
          ),
          avatarChild: (context, data) => PreferredSize(
            preferredSize: Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(data.avatar),
            ),
          ),
          contentChild: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.userName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data.content}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w300, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          child: Text('Thích'),
                          onTap: () {},
                        ),
                        // SizedBox(
                        //   width: 24,
                        // ),
                        // GestureDetector(
                        //   child: Text('Trả lời'),
                        //   onTap: () {
                        //     setState(() {
                        //       commentReplied =
                        //           'Đang trả lời ${data.userName}';
                        //     });
                        //   },
                        // ),
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
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.userName}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data.content}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w300, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          child: Text('Thích'),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                          child: Text('Trả lời'),
                          onTap: () {
                            setState(() {
                              commentReplied = 'Đang trả lời ${data.userName}';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return comments.isEmpty
        ? Scaffold(
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
                child: Text(
                  'Chưa có bình luận nào',
                  style: TextStyle(color: Colors.white),
                )),
          )
        : Scaffold(
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
                child: Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(children: cmtTreeWidge)),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 75,
                        width: MediaQuery.of(context).size.width * 0.915,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Viết bình luận',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    commentReplied.isEmpty
                        ? Positioned(child: Text(''))
                        : Positioned(
                            right: 0,
                            bottom: 85,
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.xmark,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  commentReplied = '';
                                });
                              },
                            ),
                          ),
                    commentReplied.isEmpty
                        ? Positioned(child: Text(''))
                        : Positioned(
                            left: 0,
                            bottom: 85,
                            child: Row(
                              children: [
                                Text(
                                  commentReplied,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                  ],
                )),
          );
  }
}
