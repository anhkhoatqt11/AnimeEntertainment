import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/comment.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/providers/comic_comment_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/services/reports_api.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterComment extends StatefulWidget {
  final String sourceId;
  final String type;

  const ComicChapterComment(
      {super.key, required this.sourceId, required this.type});

  @override
  State<ComicChapterComment> createState() => _ComicChapterCommentState();
}

class _ComicChapterCommentState extends State<ComicChapterComment> {
  final commentController = TextEditingController();
  String commentReplied = '';
  String commentIdReplied = '';
  String userIdIsReplied = '';
  late bool isLoading = false;
  late List<Comments> comments = [];
  late List<CommentTreeWidget> cmtTreeWidge = [];
  late String commentReportId = "";
  late String reportedPersonId = "";
  final List<String> dropList = [
    "Ngôn ngữ thô tục",
    "Nội dung công kích",
    "Khác"
  ];
  Future<List<Comments>> getComicComments() async {
    if (widget.type == "chapter") {
      return await ComicsApi.getComicChapterComments(context, widget.sourceId);
    }
    return await AnimesApi.getAnimeEpisodeComments(context, widget.sourceId);
  }

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
    getComicComments().then((value) => setState(() {
          comments = value;
          loadComments();
        }));
  }

  void loadComments() {
    setState(() {
      isLoading = true;
      print(isLoading);
      cmtTreeWidge.clear();
      int a = 0;
      List<Comment> replies = [];
      for (var comment in comments) {
        a = a + 1;
        replies = [];
        comment.replies!.forEach((element) {
          replies.add(Comment(
              id: element["_id"],
              avatar: element['avatar'],
              userId: element['userId'],
              userName: element['userName'],
              content: element['content'],
              likes: element['likes']));
        });
        setState(() {
          cmtTreeWidge.add(CommentTreeWidget(
            Comments(
                id: comment.id,
                avatar: comment.avatar,
                userId: comment.userId,
                userName: comment.userName,
                content: comment.content,
                likes: comment.likes),
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
                    width: 400,
                    decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(6)),
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
                                  color: Colors.white),
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
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 6),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11),
                      child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      hasLikeComment(
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .user
                                                  .id,
                                              data.likes)
                                          ? 'Đã thích'
                                          : 'Thích',
                                      style: TextStyle(
                                          color: hasLikeComment(
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .user
                                                      .id,
                                                  data.likes)
                                              ? Utils.primaryColor
                                              : Colors.white),
                                    ),
                                    onTap: () async {
                                      if (Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .user
                                              .authentication['sessionToken'] ==
                                          "") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                        return;
                                      } else {
                                        var userId = Provider.of<UserProvider>(
                                                context,
                                                listen: false)
                                            .user
                                            .id;

                                        if (widget.type == "chapter") {
                                          await ComicsApi
                                              .updateUserLikeChildComment(
                                                  context,
                                                  widget.sourceId,
                                                  userId,
                                                  comment.id,
                                                  data.id);
                                        } else {
                                          await AnimesApi
                                              .updateUserLikeChildComment(
                                                  context,
                                                  widget.sourceId,
                                                  userId,
                                                  comment.id,
                                                  data.id);
                                        }

                                        await getComicComments()
                                            .then((value) => setState(() {
                                                  comments.clear();
                                                  comments = value;
                                                  loadComments();
                                                }));
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  GestureDetector(
                                    child: Text('Báo cáo'),
                                    onTap: () {
                                      if (Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .user
                                              .authentication['sessionToken'] ==
                                          "") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                        return;
                                      } else {
                                        setState(() {
                                          commentReportId = data.id;
                                          reportedPersonId = data.userId;
                                        });
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 150,
                                              color: Color(0xFF2A2A2A),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                      dropList.length,
                                                      (index) => Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await ReportsApi.sendUserReport(
                                                                      context,
                                                                      dropList[
                                                                          index],
                                                                      reportedPersonId,
                                                                      Provider.of<UserProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .user
                                                                          .id,
                                                                      widget.type ==
                                                                              "chapter"
                                                                          ? "comic"
                                                                          : "anime",
                                                                      widget
                                                                          .sourceId,
                                                                      commentReportId);
                                                                  GFToast.showToast(
                                                                      'Đã gửi báo cáo cho quản trị viên.',
                                                                      context,
                                                                      toastPosition:
                                                                          GFToastPosition
                                                                              .BOTTOM,
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: GFColors
                                                                            .LIGHT,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      backgroundColor:
                                                                          GFColors
                                                                              .DARK,
                                                                      trailing:
                                                                          Icon(
                                                                        Icons
                                                                            .notifications,
                                                                        color: GFColors
                                                                            .SUCCESS,
                                                                        size:
                                                                            16,
                                                                      ));
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          20.0),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Text(
                                                                    dropList[
                                                                        index],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                              Divider(
                                                                thickness: .5,
                                                              )
                                                            ],
                                                          )),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              data.likes.length > 0
                                  ? Row(
                                      children: [
                                        Text(
                                          '${data.likes.length}',
                                          style: TextStyle(
                                              color: Utils.primaryColor),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.solidThumbsUp,
                                          color: Utils.primaryColor,
                                          size: 10,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          )),
                    ),
                  ),
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
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(6)),
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
                                  color: Colors.white),
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
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 6),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  child: Text(
                                    hasLikeComment(
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .user
                                                .id,
                                            data.likes)
                                        ? 'Đã thích'
                                        : 'Thích',
                                    style: TextStyle(
                                        color: hasLikeComment(
                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .id,
                                                data.likes)
                                            ? Utils.primaryColor
                                            : Colors.white),
                                  ),
                                  onTap: () async {
                                    if (Provider.of<UserProvider>(context,
                                                listen: false)
                                            .user
                                            .authentication['sessionToken'] ==
                                        "") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                      return;
                                    } else {
                                      var userId = Provider.of<UserProvider>(
                                              context,
                                              listen: false)
                                          .user
                                          .id;
                                      if (widget.type == "chapter") {
                                        await ComicsApi
                                            .updateUserLikeParentComment(
                                                context,
                                                widget.sourceId,
                                                userId,
                                                data.id);
                                      } else {
                                        await AnimesApi
                                            .updateUserLikeParentComment(
                                                context,
                                                widget.sourceId,
                                                userId,
                                                data.id);
                                      }
                                      await getComicComments()
                                          .then((value) => setState(() {
                                                comments.clear();
                                                comments = value;
                                                loadComments();
                                              }));
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                GestureDetector(
                                  child: Text('Trả lời'),
                                  onTap: () {
                                    if (Provider.of<UserProvider>(context,
                                                listen: false)
                                            .user
                                            .authentication['sessionToken'] ==
                                        "") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                      return;
                                    } else {
                                      setState(() {
                                        commentIdReplied = data.id;
                                        userIdIsReplied = data.userId;
                                        commentReplied = ' ${data.userName}';
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                GestureDetector(
                                  child: Text('Báo cáo'),
                                  onTap: () {
                                    if (Provider.of<UserProvider>(context,
                                                listen: false)
                                            .user
                                            .authentication['sessionToken'] ==
                                        "") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                      return;
                                    } else {
                                      setState(() {
                                        commentReportId = data.id;
                                        reportedPersonId = data.userId;
                                      });
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 150,
                                            color: Color(0xFF2A2A2A),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(
                                                    dropList.length,
                                                    (index) => Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await ReportsApi.sendUserReport(
                                                                    context,
                                                                    dropList[
                                                                        index],
                                                                    reportedPersonId,
                                                                    Provider.of<UserProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .user
                                                                        .id,
                                                                    widget.type ==
                                                                            "chapter"
                                                                        ? "comic"
                                                                        : "anime",
                                                                    widget
                                                                        .sourceId,
                                                                    commentReportId);
                                                                GFToast.showToast(
                                                                    'Đã gửi báo cáo cho quản trị viên.',
                                                                    context,
                                                                    toastPosition:
                                                                        GFToastPosition
                                                                            .BOTTOM,
                                                                    textStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: GFColors
                                                                          .LIGHT,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    backgroundColor:
                                                                        GFColors
                                                                            .DARK,
                                                                    trailing:
                                                                        Icon(
                                                                      Icons
                                                                          .notifications,
                                                                      color: GFColors
                                                                          .SUCCESS,
                                                                      size: 16,
                                                                    ));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        20.0),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Text(
                                                                  dropList[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              thickness: .5,
                                                            )
                                                          ],
                                                        )),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            data.likes.length > 0
                                ? Row(
                                    children: [
                                      Text(
                                        '${data.likes.length}',
                                        style: TextStyle(
                                            color: Utils.primaryColor),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.solidThumbsUp,
                                        color: Utils.primaryColor,
                                        size: 10,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ));
        });
        if (a == comments.length) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              isLoading = false;
            });
            print(isLoading);
          });
        }
      }
      if (comments.isEmpty) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  bool hasLikeComment(String userId, List value) {
    return value.contains(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              color: Colors.white.withOpacity(0.9),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
          centerTitle: true,
          title: Text(
            "Bình luận",
            style: TextStyle(fontSize: 16),
          ),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF141414)),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Stack(
            children: [
              isLoading == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: const Center(
                        child: GFLoader(type: GFLoaderType.circle),
                      ))
                  : comments.isNotEmpty && !isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: ListView(children: cmtTreeWidge),
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/commentempty.png",
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              ),
                              Text(
                                'Chưa có bình luận nào',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Hãy là người đầu tiên bình luận nào',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              )
                            ],
                          ),
                        ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: Provider.of<UserProvider>(context, listen: false)
                              .user
                              .authentication['sessionToken'] !=
                          ""
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Container(
                            color: const Color(0xFF141414),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    controller: commentController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                        ),
                                        hintText: 'Viết bình luận',
                                        hintStyle: TextStyle(
                                            color: Colors.white, fontSize: 13)),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white.withOpacity(0.9),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    var userId = Provider.of<UserProvider>(
                                            context,
                                            listen: false)
                                        .user
                                        .id;
                                    await Provider.of<ComicCommentProvider>(
                                            context,
                                            listen: false)
                                        .checkUserBanned(context, userId);
                                    if (Provider.of<ComicCommentProvider>(
                                            context,
                                            listen: false)
                                        .commentAccessDate
                                        .isAfter(DateTime.now())) {
                                      var formattedDate =
                                          Provider.of<ComicCommentProvider>(
                                                  context,
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
                                    await Provider.of<ComicCommentProvider>(
                                            context,
                                            listen: false)
                                        .checkValidContent(
                                            commentController.text);

                                    if (!Provider.of<ComicCommentProvider>(
                                            context,
                                            listen: false)
                                        .isValidContent) {
                                      showDialog(
                                          context: context,
                                          builder: (_) => CustomAlertDialog(
                                              content:
                                                  'Bình luận của bạn vi phạm quy tắc cộng đồng. Bạn sẽ bị cấm bình luận trong 3 ngày.',
                                              title: 'Cảnh báo',
                                              action: () {}));

                                      await Provider.of<ComicCommentProvider>(
                                              context,
                                              listen: false)
                                          .banUser(context, userId);

                                      commentController.text = '';
                                      return;
                                    }

                                    if (commentReplied.isEmpty) {
                                      if (widget.type == "chapter") {
                                        await Provider.of<ComicCommentProvider>(
                                                context,
                                                listen: false)
                                            .addRootComment(
                                                context,
                                                widget.sourceId,
                                                userId,
                                                commentController.text);
                                      } else {
                                        await AnimesApi.addRootEpisodeComment(
                                            context,
                                            widget.sourceId,
                                            userId,
                                            commentController.text);
                                      }
                                    } else {
                                      if (widget.type == "chapter") {
                                        await Provider.of<ComicCommentProvider>(
                                                context,
                                                listen: false)
                                            .addChildComment(
                                                context,
                                                widget.sourceId,
                                                commentIdReplied,
                                                userId,
                                                commentController.text);
                                      } else {
                                        await AnimesApi.addChildEpisodeComment(
                                            context,
                                            widget.sourceId,
                                            commentIdReplied,
                                            userId,
                                            commentController.text);
                                      }
                                      UsersApi.sendPushNoti(userIdIsReplied);
                                      UsersApi.addCommentNotiToUser(
                                          userIdIsReplied,
                                          widget.sourceId,
                                          widget.type == "chapter"
                                              ? "commentChapter"
                                              : "commentEpisode");
                                    }

                                    commentController.text = '';
                                    commentReplied = '';

                                    await getComicComments()
                                        .then((value) => setState(() {
                                              comments.clear();
                                              comments = value;
                                              loadComments();
                                            }));
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.solidPaperPlane,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GradientSquareButton(
                          content: 'Vui lòng đăng nhập để bình luận',
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 40,
                          cornerRadius: 12,
                          action: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                        )),
              commentReplied.isEmpty
                  ? Positioned(child: Text(''))
                  : Positioned(
                      right: 0,
                      bottom: 70,
                      child: GestureDetector(
                        child: FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.white,
                          size: 16,
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
                      bottom: 70,
                      child: Row(
                        children: [
                          Text(
                            'Đang trả lời',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            commentReplied,
                            style: TextStyle(
                                color: Utils.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    )
            ],
          )),
    );
  }
}
