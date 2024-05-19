import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/model/comment.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/providers/comic_comment_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterComment extends StatefulWidget {
  final String chapterId;

  const ComicChapterComment({super.key, required this.chapterId});

  @override
  State<ComicChapterComment> createState() => _ComicChapterCommentState();
}

class _ComicChapterCommentState extends State<ComicChapterComment> {
  final commentController = TextEditingController();
  String commentReplied = '';
  String commentIdReplied = '';
  String userId = '65ec67ad05c5cb2ad67cfb3f';
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
    FirebaseApi().listenEvent(context);
    getComicChapterComments().then((value) => setState(() {
          comments = value;

          loadComments();
        }));
  }

  void loadComments() {
    setState(() {
      cmtTreeWidge.clear();
      for (var comment in comments) {
        List<Comment> replies = [];
        comment.replies!.forEach((element) {
          replies.add(Comment(
              id: element["_id"],
              avatar: element['avatar'],
              userName: element['userName'],
              content: element['content']));
        });

        cmtTreeWidge.add(CommentTreeWidget(
          Comment(
              id: comment.id,
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
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        // GestureDetector(
                        //   child: Text('Thích'),
                        //   onTap: () {},
                        // ),
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
                        // GestureDetector(
                        //   child: Text('Thích'),
                        //   onTap: () {},
                        // ),
                        // SizedBox(
                        //   width: 24,
                        // ),
                        GestureDetector(
                          child: Text('Trả lời'),
                          onTap: () {
                            setState(() {
                              commentIdReplied = data.id;
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: commentController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Viết bình luận',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Positioned(
                        left: MediaQuery.of(context).size.width * 0.85,
                        bottom: 0,
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.19,
                          child: GestureDetector(
                            child: FaIcon(
                              FontAwesomeIcons.paperPlane,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              // if (Provider.of<UserProvider>(context,
                              //             listen: false)
                              //         .user
                              //         .authentication['sessionToken'] !=
                              //     "") {
                              //   setState(() {
                              //     userId = Provider.of<UserProvider>(context,
                              //           listen: false)
                              //       .user
                              //       .id;
                              //   });
                              // } else {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => const Login()));
                              // }

                              FocusScope.of(context).unfocus();

                              await Provider.of<ComicCommentProvider>(context,
                                      listen: false)
                                  .checkUserBanned(context, userId);

                              if (Provider.of<ComicCommentProvider>(context,
                                      listen: false)
                                  .commentAccessDate
                                  .isAfter(DateTime.now())) {
                                var formattedDate =
                                    Provider.of<ComicCommentProvider>(context,
                                            listen: false)
                                        .formattedDate;

                                showDialog(
                                    context: context,
                                    builder: (_) => CustomAlertDialog(
                                        content:
                                            'Bạn đang bị cấm bình luận vì vi phạm quy tắc cộng đồng. Thời gian bạn có thể bình luận tiếp là $formattedDate',
                                        title: 'Thông báo',
                                        action: () {}));
                                commentController.text = '';
                                return;
                              }

                              await Provider.of<ComicCommentProvider>(context,
                                      listen: false)
                                  .checkValidContent(commentController.text);

                              if (!Provider.of<ComicCommentProvider>(context,
                                      listen: false)
                                  .isValidContent) {
                                showDialog(
                                    context: context,
                                    builder: (_) => CustomAlertDialog(
                                        content:
                                            'Bình luận của bạn vi phạm quy tắc cộng đồng. Bạn sẽ bị cấm bình luận trong 3 ngày.',
                                        title: 'Cảnh báo',
                                        action: () {}));

                                await Provider.of<ComicCommentProvider>(context,
                                        listen: false)
                                    .banUser(context, userId);

                                commentController.text = '';
                                return;
                              }

                              if (commentReplied.isEmpty) {
                                await Provider.of<ComicCommentProvider>(context,
                                        listen: false)
                                    .addRootComment(context, widget.chapterId,
                                        userId, commentController.text);
                              } else {
                                await Provider.of<ComicCommentProvider>(context,
                                        listen: false)
                                    .addChildComment(
                                        context,
                                        widget.chapterId,
                                        commentIdReplied,
                                        userId,
                                        commentController.text);
                              }

                              commentController.text = '';
                              commentReplied = '';

                              await getComicChapterComments()
                                  .then((value) => setState(() {
                                        comments = value;

                                        loadComments();
                                      }));
                            },
                          ),
                        )),
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
