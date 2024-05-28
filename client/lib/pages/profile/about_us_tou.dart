import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class AboutUsToU extends StatelessWidget {
  const AboutUsToU({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: AppBar(
          backgroundColor: const Color(0xFF141414),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text("ĐIỀU KHOẢN SỬ DỤNG",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 24),
                Text(
                  '''
I. Mục đích, nội dung – Điều khoản sử dụng
1. Mục đích, nội dung dịch vụ
- Ứng Dụng Skylark App chuyên chia sẻ video, clip liên quan lĩnh vực giải trí, đời sống.
2. Điều khoản sử dụng
- Để truy cập và sử dụng Dịch vụ Ứng Dụng Skylark, Thành viên phải đồng ý và tuân theo các điều khoản được quy định tại Thỏa thuận này và quy định, quy chế mà Ứng Dụng Skylark liên kết, tích hợp, bao gồm.
- Khi truy cập, sử dụng Ứng Dụng Skylark bằng bất cứ phương tiện (máy tính, điện thoại, tivi, thiết bị kết nối Internet) hoặc sử dụng ứng dụng Ứng Dụng Skylark thì Thành viên cũng phải tuân theo Quy chế này.
- Để đáp ứng nhu cầu sử dụng của Thành viên, Ứng Dụng Skylark không ngừng hoàn thiện và phát triển, vì vậy các điều khoản quy định tại Thỏa thuận cung cấp và sử dụng dịch vụ Ứng Dụng Skylark có thể được cập nhật, chỉnh sửa bất cứ lúc nào mà không cần phải thông báo trước tới Thành viên. Ứng Dụng Skylark sẽ công bố rõ trên Website, mạng xã hội, diễn đàn về những thay đổi, bổ sung đó.
II. Đăng kí tài khoản và sử dụng dịch vụ
1. Thành viên tự chịu trách nhiệm về năng lực hành vi trong việc đăng ký tài khoản và sử dụng Ứng Dụng Skylark. Trường hợp người sử dụng Internet dưới 14 tuổi muốn đăng ký thành viên thì người giám hộ hợp pháp phải đồng ý và quyết định việc đăng ký thông tin cá nhân của mình để thể hiện sự cho phép và chịu trách nhiệm trước pháp luật về việc đăng ký đó.
2.  Sau khi Thành viên đăng nhập vào hệ thống, Thành viên có thể thay đổi tên thành viên. Tên thành viên phải tuân theo nội quy đặt tên theo quy định, không vi phạm những điều cấm của Thỏa thuận này.
3.  Thành viên phải đăng ký, đăng nhập để sử dụng Dịch vụ, chia sẻ thông tin trên Ứng Dụng Skylark. Mỗi Thành viên chỉ được đăng ký 1 tài khoản trên Ứng Dụng.
4.  Trên Website của hệ thống Ứng Dụng Skylark xuất hiện link website, hoặc biểu tượng website khác, những website này không thuộc kiểm soát hoặc sở hữu của Ứng Dụng Skylark. Việc truy cập tới các trang khác này hoàn toàn có thể gặp rủi ro, nguy hiểm. Thành viên hoàn toàn chịu trách nhiệm rủi ro khi sử dụng website liên kết này. Ứng Dụng Skylark sẽ không chịu trách nhiệm về nội dung của bất kỳ website hoặc điểm đến nào ngoài trang hệ thống các trang web của Ứng Dụng Skylark.
5. Ứng Dụng Skylark có thể được tích hợp đăng quảng cáo và quảng cáo có thể bao gồm các đường dẫn tới các website khác. Cũng như nhiều nền tảng khác, Ứng Dụng Skylark thiết lập và sử dụng cookie để tìm hiểu thêm về cách Thành viên tương tác với nội dung và giúp Ứng Dụng Skylark cải thiện trải nghiệm của Thành viên, cũng như duy trì thiết lập cá nhân của Thành viên.
6. Ứng Dụng Skylark cung cấp Tiện ích tính phí nhằm loại bỏ quảng cáo. Ứng Dụng Skylark có quyền cập nhật và thay đổi giá của Tiện ích tùy từng thời điểm. Thành viên đăng ký sử dụng Tiện ích thông qua tính năng thanh toán trong ứng dụng (In-app-purchase) Ứng Dụng Skylark trên thiết bị di động Android hoặc iOS. Sau khi thanh toán thành công, Tiện ích được kích hoạt cho Ứng Dụng Skylark trên tất cả thiết bị (máy tính, điện thoại, tivi, thiết bị kết nối Internet) cho cùng một tài khoản. Tiện ích không hỗ trợ tính năng hoàn tiền khi đã thanh toán thành công và không tự động gia hạn. 
7. Tiện ích Skylark Star là tiện ích tính phí cho phép Thành viên truy cập các nội dung độc quyền trên Skylark App. Skylark App sẽ quy định số lượng Skylark Star cần thiết để tiếp cận từng nội dung độc quyền. 
Thành viên nhận Skylark Star thông qua tính năng thanh toán trong ứng dụng di động Skylark App (In-app-purchase) trên thiết bị di động Android hoặc iOS. Số lượng Skylark Star được đồng bộ với mọi thiết bị đăng nhập trên cùng một tài khoản. 
Skylark App có quyền cập nhật và thay đổi tỷ lệ quy đổi Skylark Star tùy từng thời đểm. Tỷ lệ quy đổi mới sẽ tự động có hiệu lực tại thời điểm Skylark App có thông báo cho Thành viên. 
Sau khi thanh toán thành công, Skylark Star không hỗ trợ tính năng hoàn tiền, hay rút thành tiền mặt (cash-out).
III. Các nội dung cấm trao đổi và chia sẻ trên Ứng Dụng Skylark
Khi sử dụng các dịch vụ của hệ thống Ứng Dụng Skylark, nghiêm cấm Thành viên thực hiện một số hành vi bao gồm nhưng không giới hạn sau:
1.  Lợi dụng việc cung cấp, trao đổi, sử dụng thông tin trên Ứng Dụng Skylark nhằm mục đích:
- Chống lại Nhà nước Cộng hoà Xã hội Chủ nghĩa Việt Nam; gây phương hại đến an ninh quốc gia, trật tự, an toàn xã hội; phá hoại khối đại đoàn kết toàn dân; tuyên truyền chiến tranh xâm lược, khủng bố; gây hận thù, mâu thuẫn giữa các dân tộc, sắc tộc, chủng tộc, tôn giáo;
- Tuyên truyền, kích động bạo lực, dâm ô, đồi trụy, tội ác, tệ nạn xã hội, mê tín dị đoan, phá hoại thuần phong, mỹ tục của dân tộc.
- Tuyệt đối không bàn luận, đăng tải các nội dung về các vấn đề chính trị.
2.  Thành viên lợi dụng việc sử dụng hệ thống Ứng Dụng Skylark nhằm tiết lộ bí mật nhà nước, bí mật quân sự, an ninh, kinh tế, đối ngoại và những bí mật khác do pháp luật quy định bằng bất cứ hình thức nào trên hệ thống website Ứng Dụng Skylark.
3.  Quảng cáo, tuyên truyền, mua bán hàng hoá, dịch vụ bị cấm hoặc truyền bá tác phẩm báo chí, văn học, nghệ thuật, xuất bản phẩm bị cấm trên Ứng Dụng Skylark.
4.  Khi giao tiếp với người dùng khác, Thành viên quấy rối, chửi bới, đả kích, làm phiền hay có bất kỳ hành vi thiếu văn hoá.
5.  Thành viên có quyền sử dụng đối với hình ảnh, video của mình. Khi sử dụng hình ảnh, video của cá nhân khác, Thành viên phải được sự đồng ý của cá nhân đó. Nghiêm cấm việc sử dụng hình ảnh, video của người khác mà xâm phạm danh dự, nhân phẩm, uy tín của người có hình ảnh, video.
6.  Lợi dụng Ứng Dụng Skylark để thu thập thông tin của Thành viên, công bố thông tin, tư liệu về đời tư của Thành viên khác.
7.  Không được đặt tên thành viên (nick name, user name):
• Đặt tên thành viên theo tên của danh nhân, tên các vị lãnh đạo của Đảng và Nhà nước, tên của cá nhân, tổ chức tội phạm, phản động, khủng bố hoặc tài khoản có ý nghĩa không lành mạnh, trái với thuần phong mỹ tục.
• Tên thành viên trùng với các Điều hành viên, Quản trị viên.
• Tên thành viên cố tình trùng với thành viên khác dưới mọi hình thức, kỹ thuật.
• Tên thành viên kiểu abc1, abc2, abc3.
• Tên thành viên bao gồm các ký tự không thấy hay ẩn đi.
8.  Đưa thông tin xuyên tạc, vu khống, nhạo báng, xúc phạm uy tín tới tổ chức, cá nhân dưới bất kỳ hình thức nào (nhạo báng, chê bai, kỳ thị tôn giáo, giới tính, sắc tộc,..).
9.  Nghiêm cấm quảng bá bất kỳ sản phẩm dưới bất kỳ hình thức nào, bao gồm nhưng không giới hạn việc gửi, truyền bất kỳ thông điệp nào mang tính quảng cáo, mời gọi, thư dây truyền, cơ hội đầu tư trên Ứng Dụng Skylark.
10. Lợi dụng Ứng Dụng Skylark để tổ chức các hình thức cá cược, cờ bạc hoặc các thỏa thuận liên quan đến tiền, hiện kim, hiện vật. Chia sẻ các tài khoản fshare, megashare, tenlua, itunes, mediafire.
11. Cản trở trái pháp luật, gây rối, phá hoại hệ thống máy chủ; Cản trở việc truy cập thông tin và sử dụng các dịch vụ hợp pháp trên Ứng Dụng Skylark.
12. Sử dụng trái phép mật khẩu, khoá mật mã của các tổ chức, cá nhân, thông tin riêng, thông tin cá nhân và tài nguyên Internet.
13. Trực tiếp hoặc gián tiếp sử dụng bất kỳ thiết bị, phần mềm, trang web Internet, dịch vụ dựa trên web, hoặc các phương tiện khác để gỡ bỏ, thay đổi, bỏ qua, lẩn tránh, cản trở, hoặc phá hoại bất kỳ bản quyền, thương hiệu, hoặc các dấu hiệu về quyền sở hữu khác được đánh dấu trên Nội dung (như logo) hoặc bất kỳ hệ thống kiểm soát dữ liệu, thiết bị, biện pháp bảo vệ nội dung khác cũng như các biện pháp hạn chế truy cập từ các vùng địa lý khác nhau.
14. Trực tiếp hoặc gián tiếp thông qua bất kỳ thiết bị, phần mềm, trang web Internet, dịch vụ dựa trên web, hoặc các phương tiện khác để sao chép, tải về, chụp lại, sản xuất lại, nhân bản, lưu trữ, phân phối, tải lên, xuất bản, sửa đổi, dịch thuật, phát sóng, trình chiếu, hiển thị, bán, truyền tải hoặc truyền lại nội dung.
15. Tạo ra, tái tạo, phân phối hay quảng cáo một chi tiết của bất kỳ nội dung mà không có sự đồng ý của Ứng Dụng Skylark. Thành viên không được phép xây dựng mô hình kinh doanh sử dụng các Nội dung cho dù là có hoặc không vì lợi nhuận. Nội dung được đề cập tại Ứng Dụng Skylark bao gồm nhưng không giới hạn bất kỳ văn bản, đồ họa, hình ảnh, video, bố trí, giao diện, biểu tượng, hình ảnh, video, tài liệu âm thanh và video, và ảnh tĩnh. Ngoài ra, chúng tôi nghiêm cấm việc tạo ra các sản phẩm phát sinh hoặc vật liệu có nguồn gốc từ hoặc dựa trên bất kỳ Nội dung nào bao gồm dựng phim, làm video tương tự, hình nền, chủ đề máy tính, thiệp chúc mừng, và hàng hóa.
16. Giả mạo tổ chức, cá nhân và phát tán thông tin giả mạo, thông tin sai sự thật trên Ứng Dụng Skylark xâm hại đến quyền và lợi ích hợp pháp của tổ chức, cá nhân.
17. Tạo đường dẫn trái tới tên miền hợp pháp của tổ chức, cá nhân. Tạo, cài đặt, phát tán các phần mềm độc hại, vi rút máy tính; xâm nhập trái phép, chiếm quyền điều khiển hệ thống thông tin, tạo lập công cụ tấn công trên Internet.
18. Tuyệt đối không sử dụng bất kỳ chương trình, công cụ hay hình thức nào khác để can thiệp vào hệ thống Ứng Dụng Skylark.
19. Không được có bất kỳ hành vi nào nhằm đăng nhập trái phép hoặc tìm cách đăng nhập trái phép hoặc gây thiệt hại cho hệ thống máy chủ Ứng Dụng Skylark.
IV. Quy tắc quản lý xử phạt vi phạm người dùng
1. Các nguyên tắc đối với Thành viên:
- Thành viên vi phạm thỏa thuận cung cấp và sử dụng Ứng Dụng thì tùy theo mức độ nghiêm trọng của hành vi vi phạm sẽ bị xử phạt tương ứng.
- Trường hợp hành vi vi phạm của Thành viên chưa được quy định trong thỏa thuận này thì tùy vào tính chất, mức độ của hành vi vi phạm, Ứng Dụng Skylark sẽ đơn phương, toàn quyền quyết định mức xử phạt hợp lý.
- Hình thức xử phạt khóa tài khoản có thời hạn hoặc vĩnh viễn.
- Các hình thức xử phạt:
+ Hình thức xử phạt 1: Đình chỉ bài và gửi email cảnh cáo, nhắc nhở.
+ Hình thức xử phạt 2: Đình chỉ bài và gửi email cảnh cáo, nhắc nhở và khóa tài khoản 07 ngày
+ Hình thức xử phạt 3: Đình chỉ bài và gửi email cảnh cáo và khóa tài khoản 30 ngày hoặc khóa tài khoản vĩnh viễn.
2. Các hình thức xử phạt.
• Hình thức xử phạt 3, khóa tài khoản 30 ngày hoặc khóa vĩnh viễn được áp dụng đối với các hành vi sau:
- Thành viên có hành vi lợi dụng Ứng Dụng Skylark nhằm chống phá nước Cộng Hòa Xã Hội Chủ Nghĩa Việt Nam. Hành vi này bao gồm nhưng không giới hạn việc người dùng đặt tên thành viên cá nhân trong phòng cộng đồng trùng tên với các vĩ nhân, các vị anh hùng của dân tộc, các vị lãnh đạo của đảng và nhà nước, hoặc người dùng có sử dụng hình ảnh, video, phát ngôn, chat… có chứa thông tin bàn luận về vấn đề chính trị hoặc tiết lộ bí mật nhà nước Cộng hòa Xã hội Chủ nghĩa Việt Nam.
- Thông tin, hình ảnh, video khiêu dâm: Thành viên đăng tải hình ảnh, video, âm thanh, video khiêu dâm, chat sex hoặc đăng tải thông tin về địa chỉ phòng chát sex trực tiếp, video khiêu dâm, tuyên truyền các có nội dung khiêu dâm.
- Thông tin cá cược, cờ bạc: Lợi dụng Ứng Dụng Skylark, người dùng đăng tải nội dung thông tin, hình ảnh, video, âm thanh, video chứa thông tin để tổ chức các hình thức cá cược, cờ bạc hoặc các thỏa thuận liên quan đến tiền, hiện kim, hiện vật.
- Lan truyền thông tin lừa đảo: Sử dụng văn bản, hình ảnh, video, âm thanh hoặc video có chứa thông tin lừa đảo: giả làm chính thức hoặc các tổ chức, cá nhân; gian lận, lừa đảo tài sản của người khác.
- Phá hoại hệ thống Ứng Dụng Skylark: Thành viên lợi dụng việc sử dụng sản phẩm để xâm nhập vào hệ thống máy chủ nhằm phá hoại sản phẩm hoặc cản trở việc truy cập thông tin. Thành viên sử dụng công cụ kỹ thuật nhằm tăng điểm hoạt động, vật phẩm hoặc nhằm treo máy, spam chat.
- Sử dụng phòng cộng đồng để lôi kéo tổ chức hội họp thực tế ở bên ngoài thực hiện các hành vi vi phạm pháp luật.
- Lan truyền thông tin quảng cáo, spam hàng loạt.
- Đã vi phạm bị cảnh cáo, nhắc nhở 2 lần mà vẫn tiếp tục vi phạm.
• Hình thức xử phạt 2, khóa tài khoản 07 ngày được áp dụng đối với các hành vi sau:
- Hành vi giao tiếp: Chát khiêu dâm ở mức độ nhẹ, spam chat, kích động các thành viên khác đến các kênh khác của Ứng Dụng Skylark để gây rối hoặc tuyên truyền những thông tin vi phạm.
- Xâm phạm riêng tư: Sử dụng hình ảnh, video cá nhân của người khác, công khai những tư liệu cá nhân và những thông tin của khác như danh tính, địa chỉ, số điện thoại mà chưa được sự đồng ý và tiến hành gọi điện quấy nhiễu hoặc khích động người khác quấy nhiễu.
- Công kích người khác: Sử dụng hình ảnh, video, thông tin, âm thanh hoặc video, xúc phạm, đưa thông tin xuyên tạc, vu khống, nhạo bang, xúc phạm uy tín tới tổ chức, cá nhân.
- Vi phạm bản quyền: Ăn cắp các nội dung trên các kênh, sao chép hoặc trích dẫn mà không được phép sử dụng bản quyền của người khác.
- Đã vi phạm bị cảnh cáo, nhắc nhở 1 lần mà vẫn tiếp tục vi phạm.
• Hình thức xử phạt 1, cảnh cáo, nhắc nhở được áp dụng đối với các hành vi sau:
- Công kích, xuyên tạc, xúc phạm nhân phẩm các thành viên khác.
- Lôi kéo công đồng thành viên có chủ đích bằng các câu view sai phạm, vi phạm văn hóa đạo đức.
V. Nội dung cung cấp, trao đổi thông tin.
1.  Thành viên Ứng Dụng Skylark có thể liên hệ để cung cấp nhưng nội dung hoạt động phù hợp với các lĩnh vực hoạt động của Ứng Dụng Skylark mà không vi phạm pháp luật hay quy định của Ứng Dụng Skylark.
2.  Nội dung đăng tải ở các chuyên mục phải tương thích, phù hợp với chủ đề mà Ứng Dụng Skylark định hướng.
3. Các qui định về việc đăng tải nội dung trên Ứng Dụng bao gồm nhưng không chỉ giới hạn các điều khoản dưới đây:
- Trước khi viết bài vui lòng xem qua Ứng Dụng, diễn đàn xem đã đề cập chưa.
- Nội dung tiêu đề, bài viết phải rõ ràng, nghiêm túc.
- Không gửi một nội dung ở nhiều nơi.
- Đối với các chuyên mục có sẵn mẫu, thành viên phải gởi bài theo mẫu qui định.
- Bài trả lời không lạc đề, phải có tính xây dựng, nội dung rõ ràng.
- Khi muốn cám ơn người gởi bài, chỉ cần nhấn nút lệnh "Thích".
4.  Ứng Dụng Skylark không chứng thực bất kỳ nội dung nào được đăng tải bởi bất kỳ Thành viên nào. Ứng Dụng Skylark không cho phép các hoạt động vi phạm bản quyền và xâm phạm quyền sở hữu trí tuệ trên dịch vụ, và Ứng Dụng Skylark sẽ loại bỏ tất cả các nội dung phát hành nếu được thông báo rằng những nội dung vi phạm quyền sở hữu trí tuệ mà không cần thông báo trước.
5.  Hệ thống website Ứng Dụng Skylark cho phép Thành viên đăng tải, các video, thông tin, hình ảnh, video khác lên trên website trừ những nội dung cấm được quy định trong bản Thỏa thuận này và các văn bản pháp luật liên quan.
6.  Thành viên là người thực hiện được quyền trò chuyện, chia sẻ kinh nghiệm, giao lưu trực tuyến, bình chọn, … phù hợp với các quy định của Ứng Dụng Skylark. Thành viên đồng ý rằng Thành viên sẽ không đăng tải lên Ứng Dụng Skylark các nội dung đã có bản quyền, các bí mật thương mại hoặc các nội dung khác liên quan tới các quyền sở hữu trí tuệ của bên thứ ba, trừ trường hợp Thành viên là chủ sở hữu hợp pháp của các nội dung này hoặc có sự chấp thuận từ chủ sở hữu.
7.  Thành viên có thể sẽ chịu trách nhiệm bồi thường thiệt hại dân sự, khả năng bị phạt vi phạm hành chính hoặc bị truy tố trách nhiệm hình sự nếu có hành vi vi phạm quyền tác giả hoặc quyền liên quan.
8.  Thành viên cho phép Ứng Dụng Skylark được sử dụng, phát tán, trình chiếu, chỉnh sửa, biên soạn bất kỳ ý tưởng, khái niệm, cách thức, đề xuất, gợi ý, bình luận hoặc hình thức khác của Thành viên mà Thành viên cung cấp, trao đổi, chia sẻ thông qua việc sử dụng hệ thống website Ứng Dụng Skylark một cách hoàn toàn miễn phí nhằm mục đích nâng cấp, quảng bá, xúc tiến, v.v. cho sự phát triển của Ứng Dụng Skylark. Thành viên đồng ý từ bỏ bất kỳ quyền và yêu cầu với bất kỳ khoản tiền thưởng, phí, nhuận bút, lệ phí hoặc các chi trả khác liên quan đến việc Ứng Dụng Skylark sử dụng, phát tán, trình chiếu, chỉnh sửa, biên soạn bất kỳ hoặc tất cả những thông tin, hình ảnh, video mà Thành viên cung cấp, chia sẻ, trao đổi của Thành viên như trong điều khoản này.
9. Thành viên được quyền sử dụng lại thông tin đăng tải bao gồm nhưng không giới hạn việc chỉnh sửa lại, biên soạn, phân tán, trình chiếu nội dung đăng tải đó vì mục đích cá nhân hoặc phi thương mại.
10.  Tại các khu vực được phép truyền phát hình ảnh, video, đăng tải bài viết, Thành viên có thể chia sẻ thông tin, hình ảnh, video được phép dưới các định dạng Ứng Dụng Skylark mặc định. Thành viên đồng ý cam kết thực hiện trách nhiệm đảm bảo sử dụng hợp pháp nội dung thông tin số đưa lên đăng tải trên hệ thống mạng Internet.
11. Trong mọi trường hợp, Ứng Dụng Skylark được quyền xử lý các thông tin đăng tải cho phù hợp với thuần phong mỹ tục, các quy tắc đạo đức và các quy tắc đảm bảo an ninh quốc gia, và chúng tôi có toàn quyền cho phép hoặc không cho phép bài viết, thông tin, hình ảnh, video của Thành viên xuất hiện hay tồn tại trên hệ thống website Ứng Dụng Skylark.
12. Thành viên hiểu và đồng ý rằng, khi sử dụng website và Ứng Dụng này, Thành viên sẽ tiếp nhận nhiều nội dung thông tin, hình ảnh, video được đăng tải từ nhiều nguồn khác nhau. Ứng Dụng Skylark không chịu trách nhiệm về mức độ chính xác, tính hữu ích, độ an toàn, hoặc các quyền sở hữu trí tuệ liên quan tới những thông tin mà Thành viên khác đăng tải. Khi sử dụng sản phẩm có thể Thành viên thấy một vài thông tin, bình luận do Thành viên khác đăng tải không đúng sự thật, hoặc gây phản cảm, trong trường hợp này, Thành viên có thể liên hệ với Ứng Dụng Skylark để tiến hành các biện pháp cần thiết để đảm bảo quyền lợi.
13. Ứng Dụng Skylark quan tâm tới sự an toàn và riêng tư, quyền lợi của tất cả thành viên sử dụng sản phẩm của mình, đặc biệt là trẻ em. Vì vậy, nếu Thành viên là cha mẹ hoặc người giám hộ hợp pháp của Thành viên khác, Thành viên có trách nhiệm xem xét và xác định sản phẩm, nội dung nào của Ứng Dụng Skylark thích hợp cho con em của mình. Tương tự, nếu Thành viên là trẻ em thì Thành viên phải hỏi ý kiến cha mẹ hoặc người giám hộ hợp pháp của mình về việc sản phẩm, nội dung mình sử dụng có phù hợp hay không.
14. Khi Thành viên truy cập vào sản phẩm khác, ứng dụng hoặc website liên kết với Ứng Dụng này, Thành viên phải hiểu và tuân thủ những quy định về sản phẩm mà Thành viên sử dụng. Có thể có những sản phẩm không thuộc quyền sở hữu của Ứng Dụng Skylark, và do vậy Thành viên phải tự chịu trách nhiệm những rủi ro phát sinh khi sử dụng sản phẩm này.
15. Nhằm đảm bảo sự hài lòng của khách hàng, Ứng Dụng Skylark luôn sáng tạo, nâng cấp sản phẩm được tốt hơn, vì vậy, sản phẩm này có thể được phát triển trên thiết bị viễn thông hoặc công nghệ khác (nếu có), và do vậy có thể những thông tin liên quan cá nhân sẽ được hiển thị bao gồm nhưng không giới hạn như địa điểm nơi Thành viên đang sử dụng dịch vụ, sản phẩm.
VI. Quyền và nghĩa vụ của Thành viên
1. Được sử dụng dịch vụ Ứng Dụng Skylark theo đúng thỏa thuận sử dụng dịch vụ giữa Ứng Dụng Skylark và Thành viên.
2. Được bảo vệ bí mật thông tin riêng và thông tin cá nhân theo thỏa thuận này và các quy định của pháp luật về bảo mật thông tin cá nhân.
3. Tuân thủ quy chế quản lý, cung cấp và sử dụng Ứng Dụng.
4. Chịu trách nhiệm về nội dung thông tin do mình lưu trữ, cung cấp, đưa trên Ứng Dụng Skylark.
5.  Thành viên có trách nhiệm bảo mật thông tin tài khoản, nếu những thông tin trên bị tiết lộ dưới bất kỳ hình thức nào thì Thành viên phải chấp nhận những rủi ro phát sinh. Ứng Dụng Skylark sẽ căn cứ vào những thông tin hiện có trong tài khoản để làm căn cứ quyết định chủ sở hữu tài khoản nếu có tranh chấp và chúng tôi sẽ không chịu trách nhiệm về mọi tổn thất phát sinh.
6.  Thành viên đồng ý sẽ thông báo ngay cho Ứng Dụng Skylark về bất kỳ trường hợp nào sử dụng trái phép tài khoản và mật khẩu của Thành viên hoặc bất kỳ các hành động phá vỡ hệ thống bảo mật nào. Thành viên cũng bảo đảm rằng, Thành viên luôn thoát tài khoản của mình sau mỗi lần sử dụng.
7.  Khi phát hiện ra lỗi của Ứng Dụng Skylark hay các nội dung vi phạm, Thành viên thông báo cho Ban quản lý Ứng Dụng Skylark qua phương thức sau:
- Website: https://Skylark.vn
- Email: Skylarkapp-support@Skylark.vn
- Điện thoại: 02862921652
8.  Thành viên có thể sẽ bị xử phạt vi phạm hành chính, bị truy tố trách nhiệm hình sự nếu Thành viên vi phạm về quyền tác giả, quyền liên quan khi Thành viên sử dụng sản phẩm Ứng Dụng Skylark này.
9.  Thành viên phải tuân thủ tuyệt đối quy định về các hành vi cấm, các nội dung trao đổi cung cấp thông tin được quy định trong quy chế này. Nếu vi phạm một hoặc nhiều hành vi, tùy thuộc vào mức độ vi phạm Ứng Dụng Skylark sẽ tiến hành khóa tài khoản vĩnh viễn và có thể sẽ yêu cầu cơ quan chức năng truy tố Thành viên trước pháp luật nếu cần thiết.
10.  Thực hiện quyền và trách nhiệm khác theo quy định pháp luật.
VII. Quyền và trách nhiệm của Ứng Dụng Skylark
1. Cung cấp Ứng Dụng Skylark trừ các dịch vụ bị cấm theo quy định của pháp luật.
2. Công khai thỏa thuận cung cấp và sử dụng Ứng Dụng Skylark.
3. Ứng Dụng Skylark phải có biện pháp bảo vệ bí mật thông tin riêng, thông tin cá nhân của Thành viên; thông báo cho Thành viên về quyền, trách nhiệm và các rủi ro khi lưu trữ, trao đổi và chia sẻ thông tin trên mạng.
4. Ứng Dụng Skylark phải bảo đảm quyền quyết định của Thành viên khi cho phép thông tin cá nhân của mình được cung cấp cho tổ chức, doanh nghiệp, cá nhân khác.
5. Ứng Dụng Skylark có trách nhiệm phối hợp với cơ quan quản lý nhà nước có thẩm quyền để loại bỏ hoặc ngăn chặn thông tin có nội dung vi phạm quy định của pháp luật.
6. Ứng Dụng Skylark có quyền cung cấp thông tin cá nhân và thông tin riêng của Thành viên có liên quan đến hoạt động khủng bố, tội phạm, vi phạm pháp luật khi có yêu cầu của cơ quan quản lý nhà nước có thẩm quyền.
7. Ứng Dụng Skylark có hệ thống máy chủ đặt tại Việt Nam đáp ứng việc thanh tra, kiểm tra, lưu trữ, cung cấp thông tin theo yêu cầu của cơ quan quản lý nhà nước có thẩm quyền và giải quyết khiếu nại của khách hàng đối với việc cung cấp dịch vụ theo quy định của Bộ Thông tin và Truyền thông.
8. Thực hiện việc đăng ký, lưu trữ và quản lý thông tin cá nhân của người thiết lập trang thông tin điện tử cá nhân và người cung cấp thông tin khác trên Ứng Dụng theo quy định của Bộ Thông tin và Truyền thông. Bảo đảm chỉ những người đã cung cấp đầy đủ, chính xác thông tin cá nhân theo quy định mới được thiết lập trang thông tin điện tử cá nhân hoặc cung cấp thông tin trên Ứng Dụng.
9. Ứng Dụng Skylark sẽ tiến hành báo cáo theo quy định và chịu sự thanh tra, kiểm tra của các cơ quan quản lý nhà nước có thẩm quyền.
10. Trong quá trình sử dụng sản phẩm, nếu Thành viên vi phạm bất cứ điều khoản nào trong Thỏa thuận cung cấp Ứng Dụng này, chúng tôi có toàn quyền chấm dứt, xóa bỏ tài khoản của Thành viên mà không cần sự đồng ý của Thành viên và không phải chịu bất cứ trách nhiệm nào đối với Thành viên.
11.  Mọi vi phạm của chủ tài khoản trong quá trình sử dụng sản phẩm Ứng Dụng Skylark, chúng tôi có quyền tước bỏ mọi quyền lợi của chủ tài khoản đối với việc sử dụng sản phẩm cũng như sẽ yêu cầu cơ quan chức năng truy tố Thành viên trước pháp luật nếu cần thiết.
12.  Khi phát hiện những vi phạm như sử dụng hacks, truyền bá nội dung cấm hoặc những lỗi khác, Ứng Dụng Skylark có quyền sử dụng những thông tin mà Thành viên cung cấp khi đăng ký tài khoản để chuyển cho Cơ quan chức năng giải quyết theo quy định của pháp luật.
13.  Khi phát hiện những vi phạm về nội dung cấm được quy định tại Thỏa thuận này, Ứng Dụng Skylark có quyền không cho hiển thị ngay lập tức các thông tin vi phạm đã cập nhật bởi Thành viên và/hoặc cảnh cáo, khóa, tạm dừng tài khoản của Thành viên vi phạm. Trong trường hợp nhận được tố cáo của Thành viên khác, Ứng Dụng Skylark sẽ tiến hành giám sát kiểm tra và log data cùng những chứng cứ liên quan, nếu phát hiện vi phạm Ứng Dụng Skylark có quyền không cho hiển thị ngay lập tức các thông tin vi phạm đã cập nhật bởi Thành viên và/hoặc cảnh cáo, khóa, tạm dừng tài khoản của Thành viên vi phạm. Chúng tôi (Ứng Dụng Skylark) có toàn quyền quyết định các hình thức xử lý đối với các trường hợp vi phạm. Tuy vào tính chất sự việc, mức độ ảnh hưởng và nghiêm trọng, chúng tôi sẽ đưa ra hình thức xử lý phù hợp. Quyết định của Ứng Dụng Skylark là quyết định cuối cùng và người dùng đồng ý chấp hành.
14.  Có trách nhiệm hỗ trợ chủ tài khoản trong quá trình sử dụng sản phẩm của Ứng Dụng Skylark.
15.  Nhận và giải quyết khiếu nại của Thành viên các trường hợp phát sinh trong quá trình sử dụng Ứng Dụng Skylark, tuy nhiên chúng tôi chỉ hỗ trợ, nhận và giải quyết đối với tài khoản đăng ký đầy đủ thông tin, trung thực và chính xác.
VIII. Giới hạn trách nhiệm và từ chối đảm bảo.
1.  Trong quá trình vận hành Ứng Dụng Skylark, chúng tôi sẽ chỉ chịu trách nhiệm theo quy định của pháp luật đối với các vấn liên quan đến lỗi hệ thống kỹ thuật của Ứng Dụng Skylark.
2.  Nếu phát sinh rủi ro, thiệt hại trong trường hợp bất khả kháng bao gồm nhưng không giới hạn như chập điện, hư hỏng phần cứng, phần mềm, sự cố đường truyền Internet hoặc do thiên tai, ... người dùng phải chấp nhận những rủi ro, thiệt hại nếu có. Chúng tôi cam kết sẽ nỗ lực giảm thiểu những rủi ro, thiệt hại phát sinh tuy nhiên Ứng Dụng Skylark sẽ không chịu bất cứ trách nhiệm nào phát sinh trong các trường hợp này.
3. Chúng tôi (Ứng Dụng Skylark) hoàn toàn không chịu trách nhiệm rủi ro về mọi giao dịch của Thành viên với bên thứ 3 trong quá trình sử dụng sản phẩm Ứng Dụng Skylark. Khi Thành viên sử dụng sản phẩm và/hoặc giao dịch với bên thứ 3, Thành viên đã hiểu và đồng ý tự chịu trách nhiệm những rủi ro phát sinh.
4.  Bài viết, hình ảnh, video, media của Thành viên có thể có những hạn chế, có thể gây phản đối, bất hợp pháp, không chính xác, hoặc không phù hợp, Ứng Dụng Skylark không có trách nhiệm cho bất kỳ bài viết nào, clip, video, hình ảnh nào. Nội dung được đăng không phản ánh quan điểm hay chính sách của chúng tôi (Ứng Dụng Skylark). Chúng tôi có quyền, nhưng không có nghĩa vụ, giám sát và hạn chế hoặc loại bỏ các nội dung đăng tải trên trừ khi chúng tôi có cơ sở cho rằng, nội dung được đăng tải là vi phạm thỏa thuận này cũng như vi phạm pháp luật.
IX.  Bản quyền và quy trình báo cáo vi phạm bản quyền
1. Tại các khu vực được phép đăng tải nội dung, Thành viên có thể chia sẻ thông tin được phép dưới các định dạng chúng tôi mặc định và Thành viên phải tự chịu trách nhiệm đối với các nội dung, thông tin, hình ảnh, video và bất kỳ sự chia sẻ nào khác cũng như tính hợp pháp, các trách nhiệm pháp lý đối với nội dung, thông tin, chia sẻ của Thành viên với cá nhân Thành viên hoặc nhóm Thành viên, tổ chức sử dụng. Tuy nhiên, trong mọi trường hợp, chúng tôi vẫn được bảo lưu quyền xử lý các thông tin đăng tải cho phù hợp với thuần phong mỹ tục, các quy tắc đạo đức và các quy tắc đảm bảo an ninh quốc gia, và chúng tôi có toàn quyền cho phép hoặc không cho phép bài viết của Thành viên xuất hiện hay tồn tại trên Ứng Dụng, diễn đàn hoặc tại các khu vực được phép chia sẻ thông tin.
2.  Chúng tôi có toàn quyền, bao gồm nhưng không giới hạn trong các quyền tác giả, thương hiệu, bí mật kinh doanh, nhãn hiệu và các quyền sở hữu trí tuệ khác trong sản phẩm của Ứng Dụng Skylark. Việc sử dụng quyền và sở hữu của chúng tôi cần phải được chúng tôi cho phép trước bằng văn bản. Ngoài việc được cấp phép bằng văn bản, chúng tôi không cấp phép dưới bất kỳ hình thức nào khác cho dù đó là hình thức công bố hay hàm ý để Thành viên thực hiện các quyền trên. Và do vậy, Thành viên không có quyền sử dụng sản phẩm của chúng tôi vào mục đích thương mại mà không có sự cho phép bằng văn bản của chúng tôi trước đó.
3.  Thành viên đồng ý để chúng tôi tự do sử dụng, tiết lộ, áp dụng và sửa đổi bất kỳ ý tưởng, khái niệm, cách thức, đề xuất, gợi ý, bình luận hoặc hình thức thông báo nào khác mà Thành viên cung cấp cho chúng tôi thông qua việc sử dụng sản phẩm Ứng Dụng Skylark một cách hoàn toàn miễn phí. Thành viên từ bỏ và đồng ý từ bỏ bất kỳ quyền và yêu cầu với bất kỳ khoản tiền thưởng, phí, nhuận bút, lệ phí hoặc các kiểu chi trả khác liên quan đến việc chúng tôi sử dụng, tiết lộ, áp dụng, chỉnh sửa bất kỳ hoặc tất cả phản hồi của Thành viên.
4.  Quy trình báo cáo vi phạm bản quyền:
- Nếu Thành viên tin rằng bất kỳ nội dung, tài liệu, hình ảnh, video hoặc các tài liệu khác của mình được cung cấp thông qua Dịch vụ Ứng Dụng Skylark đang bị vi phạm quyền sở hữu trí tuệ, vui lòng thông báo cho chúng tôi về việc vi phạm bản quyền theo quy trình cụ thể được quy định dưới đây.
- Chúng tôi sẽ xử lý từng thông báo vi phạm bản quyền mà chúng tôi nhận được và xử lý theo quy định của pháp luật sở hữu trí tuệ.
- Để giúp chúng tôi có đủ cơ sở đáp ứng các yêu cầu của Thành viên, vui lòng gửi thông báo bằng văn bản với các thông tin sau:
+ Chữ ký thật của chủ sở hữu hoặc người được ủy quyền thay mặt cho chủ sở hữu của một sản phẩm độc quyền.
+ Mô tả tác phẩm có bản quyền mà Thành viên cho là bị vi phạm.
+ Mô tả về nơi mà các tài liệu Thành viên cho là vi phạm nằm trên các Dịch vụ Ứng Dụng Skylark đủ để cho phép chúng tôi xác định vị trí tài liệu đó.
+ Thông tin liên hệ của Thành viên như địa chỉ, số điện thoại, email để Ứng Dụng Skylark có thể liên hệ với Thành viên.
+ Thành viên tuyên bố rằng Thành viên tin tưởng việc sử dụng nội dung đó là không được phép của chủ sở hữu quyền tác giả, đại lý độc quyền hoặc pháp luật.
+ Thành viên tuyên bố rằng các thông tin trong thông báo của Thành viên là chính xác và Thành viên chấp nhận hình phạt về tội khai man mà Thành viên được ủy quyền hành động thay mặt cho chủ sở hữu bản quyền.
+ Nếu tài khoản Ứng Dụng Skylark vi phạm về sở hữu trí tuệ thông qua việc Thành viên gửi thông báo, nếu kết quả cho thấy Tài khoản có sự vi phạm thì tùy vào mức độ nghiêm trọng của sự việc, chúng tôi (Ứng Dụng Skylark) có toàn quyền quyết định xóa tài khoản vi phạm đó.
Email liên hệ: Skylarkapp-support@Skylark.vn
X. Những rủi ro khi lưu trữ, trao đổi và chia sẻ thông tin trên Internet
- Khi chia sẻ thông tin trên Ứng Dụng, Thành viên thường cập nhật thông tin trong phần tiểu sử, ảnh, cập nhật trạng thái (những tin Thành viên chia sẻ với những người trong danh sách người dùng khác) và bình luận (những hồi đáp của Thành viên về phần cập nhật trạng thái của người khác). Những thông tin này có chiều hướng tăng dần và thường xuyên được cập nhật liên tục. Chẳng hạn, Thành viên có thể để lộ địa chỉ nơi mình sống, thời gian Thành viên thường có mặt (và vắng mặt) ở nhà, nơi làm việc hoặc trường của Thành viên. Việc chia sẻ này vô tình tạo điều kiện cho những kẻ có mưu đồ bất chính có thông tin để lên kế hoạch thực hiện một vụ án (trộm cắp, giết người, hiếp dâm,…).
- Nhiều Thành viên Internet dễ dàng để lộ thông tin trong trang cá nhân của mình. Các thông tin có thể bị bộc lộ như địa chỉ hòm thư điện tử, ngày tháng năm sinh hay số điện thoại có thể khiến Thành viên bị quấy rối, xâm phạm và mạo danh trên mạng.
- Nhiều người không lường trước được rằng một khi thông tin được chia sẻ trao đổi trên mạng, nó trở thành thông tin công cộng. Ngay cả khi chỉ chia sẻ cập nhật trạng thái với một người hoặc một nhóm người thì Thành viên cũng không thế kiểm soát được những người này sẽ làm gì với những thông tin ấy. Mặt khác, bất kỳ thông tin nào được chia sẻ trên mạng cũng có thể được xem là thông tin công cộng và từ chỗ là thông tin riêng tư sẽ bị chia sẻ và phổ biến rộng rãi. Vì vậy, chúng tôi khuyến cáo các thành viên khi tham gia Ứng Dụng chủ động cân nhắc trước khi cung cấp thông tin về cá nhân.
XI. Cơ chế giải quyết khiếu nại, tranh chấp
Ứng Dụng Skylark có trách nhiệm tiếp nhận khiếu nại và hỗ trợ các thành viên của Ứng Dụng giải quyết các tranh chấp trong phạm vi của Ứng Dụng. Thành viên có thể gửi khiếu nại đến email: Skylarkapp-support@Skylark.vn
Ứng Dụng Skylark tôn trọng và nghiêm túc thực hiện các quy định của pháp luật về giải quyết các tranh chấp, khiếu nại của các thành viên tham gia Ứng Dụng. Vì vậy, đề nghị các thành viên đăng ký hoặc viết bình luận tôn trọng lẫn nhau đồng thời cung cấp đầy đủ, chính xác, trung thực và chi tiết các thông tin liên quan đến nhân thân. Mọi hành vi lừa đảo, gian lận trong thông tin đều bị lên án và phải chịu hoàn toàn trách nhiệm trước pháp luật.
Các bên phát sinh tranh chấp khiếu nại sẽ phải có vai trò trách nhiệm trong việc tích cực giải quyết vấn đề. Đối với người gửi khiếu nại tranh chấp cần có trách nhiệm cung cấp các chứng cứ thông tin xác thực liên quan đến sự việc đang gây mâu thuẫn. Ban quản lý Ứng Dụng Skylark sẽ có trách nhiệm kiểm tra các chứng cứ, thông tin mà bên khiếu nại đưa ra và có phản hồi thông qua hệ thống đã nhận khiếu nại.
Thời hạn giải quyết khiếu nại là: 15 ngày làm việc kể từ khi nhận được thông tin từ Thành viên.
Ứng Dụng Skylark chỉ hỗ trợ, giải quyết khiếu nại, tố cáo của Thành viên trong trường hợp Thành viên đã ghi đầy đủ, trung thực và chính xác thông tin khi đăng ký tài khoản.
Đối với tranh chấp giữa Thành viên Ứng Dụng Skylark với nhau, có thể Ban quản lý Ứng Dụng Skylark sẽ gửi thông tin liên hệ cho các đối tượng tranh chấp để các bên tự giải quyết hoặc Ban quản lý Ứng Dụng Skylark sẽ căn cứ vào tình hình thực tế để giải quyết. Theo đó, Ứng Dụng Skylark sẽ bảo vệ quyền lợi tối đa có thể cho Thành viên Ứng Dụng Skylark hợp pháp và chính đáng. Sau khi các bên đã giải quyết xong tranh chấp phải có trách nhiệm báo lại cho Ban quản trị Ứng Dụng Skylark. Trong trường hợp tranh chấp phát sinh đã được chứng minh từ lỗi của một thành viên xác định Ứng Dụng Skylark sẽ có biện pháp cảnh cáo, khóa tài khoản hoặc chuyển cho cơ quan pháp luật có thẩm quyền tùy theo mức độ của sai phạm. Ứng Dụng Skylark sẽ chấm dứt và gỡ bỏ toàn bộ bài viết, bình luận của thành viên đó trên Ứng Dụng Skylark đồng thời yêu cầu thành viên đó phải công khai xin lỗi bên đã bị xâm phạm.
Nếu thông qua hình thức thỏa thuận mà vẫn không thể giải quyết được tranh chấp, mâu thuẫn phát sinh từ trao đổi giữa các bên, thì một trong hai bên sẽ có quyền nhờ đến cơ quan pháp luật có thẩm quyền can thiệp nhằm đảm bảo lợi ích hợp pháp của các bên.
XII. Thu thập thông tin các nhân và chính sách bảo vệ thông tin các nhân, thông tin riêng của Thành viên Ứng Dụng
Để đảm bảo phục vụ và cung cấp tới Thành viên các dịch vụ ngày càng tốt hơn và thực hiện việc cung cấp cho các cơ quan chức năng có thẩm quyền khi có yêu cầu, Ứng Dụng Skylark sẽ tiến hành thu thập dữ liệu của Thành viên bao gồm ít nhất: họ tên, số điện thoại, email, số CMND/Passport cùng với ngày và nơi cấp, tên đăng nhập, mật khẩu đăng nhập
1.  Mục đích và phạm vi thu thập
Việc thu thập dữ liệu chủ yếu trên Ứng Dụng Skylark bao gồm: họ tên, số điện thoại, email, số CMND/Passport cùng với ngày và nơi cấp, tên đăng nhập, mật khẩu đăng nhập. Đây là các thông tin mà Ứng Dụng Skylark cần thành viên cung cấp bắt buộc khi đăng ký sử dụng dịch vụ và để Ứng Dụng Skylark liên hệ xác nhận khi thành viên đăng ký sử dụng dịch vụ trên website nhằm đảm bảo quyền lợi cho cho chính các thành viên.
Các thành viên sẽ tự chịu trách nhiệm về bảo mật và lưu giữ mọi hoạt động sử dụng dịch vụ dưới tên đăng ký, mật khẩu và hộp thư điện tử của mình. Ngoài ra, thành viên có trách nhiệm thông báo kịp thời cho Ứng Dụng Skylark về những hành vi sử dụng trái phép, lạm dụng, vi phạm bảo mật, lưu giữ tên đăng ký và mật khẩu của bên thứ ba để có biện pháp giải quyết phù hợp.
2.  Phạm vi sử dụng thông tin
Ứng Dụng Skylark sử dụng thông tin thành viên cung cấp để:
- Cung cấp các dịch vụ đến Thành viên.
- Gửi các thông báo về các hoạt động trao đổi thông tin giữa thành viên và Ứng Dụng Skylark.
- Ngừa các hoạt động phá hủy tài khoản người dùng của thành viên hoặc các hoạt động giả mạo Thành viên.
- Liên lạc và giải quyết với thành viên trong những trường hợp đặc biệt.
- Không sử dụng thông tin cá nhân của thành viên ngoài mục đích xác nhận và liên hệ có liên quan đến hoạt động tại Ứng Dụng Skylark.
- Trong trường hợp có yêu cầu của pháp luật: Ứng Dụng Skylark có trách nhiệm hợp tác cung cấp thông tin cá nhân thành viên khi có yêu cầu từ cơ quan tư pháp bao gồm: Viện kiểm sát, tòa án, cơ quan công an điều tra liên quan đến hành vi vi phạm pháp luật nào đó của khách hàng. Ngoài ra, không ai có quyền xâm phạm vào thông tin cá nhân của thành viên.
3. Thời gian lưu trữ thông tin
Trong mọi trường hợp, thông tin cá nhân, thông tin nhật ký của thành viên, bao gồm nhưng không giới hạn, tài khoản, thời gian đăng nhập, thời gian đăng xuất, địa chỉ IP, hoạt động, nhật ký hoạt động của thành viên sẽ được bảo mật trên máy chủ của Ứng Dụng Skylark với thời gian tối thiểu là 24 tháng.
4.  Địa chỉ của đơn vị thu thập và quản lý thông tin cá nhân
Đơn vị: Công ty Cổ phần Skylark
Địa chỉ: Đường Hàn Thuyên, Khu phố 6, TP. Thủ Đức, thành phố Hồ Chí Minh.
Email: Skylarkapp-support@Skylark.vn
5.  Phương tiện và công cụ để người dùng tiếp cận và chỉnh sửa dữ liệu cá nhân của mình.
- Thành viên có quyền tự kiểm tra, cập nhật, điều chỉnh hoặc hủy bỏ thông tin cá nhân của mình bằng cách đăng nhập vào tài khoản và chỉnh sửa thông tin cá nhân hoặc yêu cầu Ứng Dụng Skylark thực hiện việc này.
- Thành viên có quyền gửi khiếu nại về việc lộ thông tin các nhân cho bên thứ 3 đến Ban quản trị của Ứng Dụng Skylark. Khi tiếp nhận những phản hồi này, Ứng Dụng Skylark sẽ xác nhận lại thông tin, phải có trách nhiệm trả lời lý do và hướng dẫn thành viên khôi phục và bảo mật lại thông tin. Email liên hệ: Skylarkapp-support@Skylark.vn
6.  Chính sách bảo mật thông tin cá nhân thành viên
- Thông tin cá nhân của thành viên trên Ứng Dụng Skylark được Ứng Dụng Skylark cam kết bảo mật tuyệt đối theo chính sách bảo vệ thông tin cá nhân của Ứng Dụng Skylark. Việc thu thập và sử dụng thông tin của mỗi thành viên chỉ được thực hiện khi có sự đồng ý của thành viên đó trừ những trường hợp pháp luật có quy định khác.
- Không sử dụng, không chuyển giao, cung cấp hay tiết lộ cho bên thứ 3 nào về thông tin cá nhân của thành viên khi không có sự cho phép đồng ý từ thành viên.
- Trong trường hợp máy chủ lưu trữ thông tin bị hacker tấn công dẫn đến mất mát dữ liệu cá nhân thành viên, Ứng Dụng Skylark sẽ có trách nhiệm thông báo vụ việc cho cơ quan chức năng điều tra xử lý kịp thời và thông báo cho thành viên được biết.
- Bảo mật tuyệt đối mọi thông tin giao dịch trực tuyến của Thành viên tại Trung tâm dữ liệu của Ứng Dụng Skylark.
- Ban quản trị Ứng Dụng Skylark yêu cầu các cá nhân khi đăng ký là thành viên, phải chịu trách nhiệm về tính pháp lý của những thông tin trên. Ban quản trị Ứng Dụng Skylark không chịu trách nhiệm cũng như không giải quyết mọi khiếu nại có liên quan đến quyền lợi của Thành viên đó nếu xét thấy tất cả thông tin cá nhân của thành viên đó cung cấp khi đăng ký ban đầu là không chính xác.
XIII. Hiệu lực của thỏa thuận.
1.  Các điều khoản quy định tại Thỏa Thuận này được quy định trên website có thể được cập nhật, chỉnh sửa bất cứ lúc nào mà không cần phải thông báo trước tới Thành viên. Ứng Dụng Skylark sẽ công bố rõ trên Website, mạng xã hội, diễn đàn, Blog – Tin tức về những thay đổi, bổ sung đó.
2.  Trong trường hợp một hoặc một số điều khoản Thỏa Thuận cung cấp và sử dụng dịch vụ Ứng Dụng Skylark này xung đột với các quy định của luật pháp Việt Nam, điều khoản đó sẽ được chỉnh sửa cho phù hợp với quy định pháp luật hiện hành, phần còn lại của Thỏa Thuận vẫn giữ nguyên giá trị.
Thỏa Thuận cung cấp và sử dụng dịch vụ Ứng Dụng Skylark có giá trị từ ngày 20 tháng 05 năm 2024.
''',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
