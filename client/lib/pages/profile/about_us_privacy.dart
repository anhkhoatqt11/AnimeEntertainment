import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class AboutUsPrivacy extends StatelessWidget {
  const AboutUsPrivacy({super.key});

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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text("CHÍNH SÁCH VỀ QUYỀN RIÊNG TƯ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 24),
                Text(
                  '''
GIẢI THÍCH TỪ NGỮ:
Thông tin: là các thông tin cá nhân của người sử dụng dịch vụ được ghi nhận trên Ứng dụng Skylark.

Khách hàng: là người sử dụng dịch vụ trên Ứng dụng Skylark.

Chính sách: là chính sách về quyền riêng tư này, có thể được cập nhật tùy từng thời điểm.

CHÍNH SÁCH VỀ QUYỀN RIÊNG TƯ CỦA ỨNG DỤNG:
Chính sách về quyền riêng tư này ("Chính sách") áp dụng cho việc xử lý thông tin nhận dạng cá nhân do bạn gửi hoặc lấy từ bạn liên quan đến Ứng dụng Skylark ("Ứng dụng"). Ứng dụng được cung cấp bởi Skylark và có thể được cung cấp bởi một cá nhân/tổ chức khác, thay mặt cho Skylark ("Đối tác Ứng dụng"). Bằng cách sử dụng hoặc truy cập vào Ứng dụng, bạn xác nhận rằng bạn chấp nhận các thông lệ và chính sách được nêu trong Chính sách về Quyền riêng tư này.

THÔNG TIN:
Chính sách này áp dụng cho dữ liệu cá nhân được Skylark ghi nhận liên quan đến dịch vụ trên Ứng dụng do Skylark cung cấp.

GHI NHẬN THÔNG TIN:
Chúng tôi thu thập dữ liệu cá nhân mà Khách hàng cung cấp cho chúng tôi. Chúng tôi có thể nhận và lưu trữ bất kỳ thông tin nào Khách hàng gửi đến Ứng dụng (hoặc cho phép chúng tôi lấy - chẳng hạn như từ (ví dụ) tài khoản Facebook của bạn). Các loại thông tin cá nhân được thu thập có thể bao gồm tên đầy đủ, địa chỉ email, giới tính, số điện thoại, địa chỉ IP, vị trí địa lý, thông tin trình duyệt, tên người dùng, thông tin nhân khẩu học và bất kỳ thông tin nào khác cần thiết mà Khách hàng đồng ý cung cấp cho chúng tôi để chúng tôi cung cấp các dịch vụ Ứng dụng. Dữ liệu này được ghi nhận từ các nguồn:

(a) Khách hàng cung cấp trực tiếp cho Skylark: Chúng tôi có thể trực tiếp ghi nhận thông tin về Khách hàng nếu Khách hàng cung cấp thông tin, chẳng hạn như khi Khách hàng đăng ký mua các nội dung có tính phí, đăng ký để nhận thông tin.

(b) Tự động ghi nhận khi Khách hàng sử dụng dịch vụ trên Ứng dụng Skylark: ví dụ cookies và các công cụ khác.

(c) Nguồn khác: nếu Khách hàng cho phép chia sẻ thông tin đó trên cơ sở dữ liệu công, và các tổ chức tổng hợp dữ liệu, và thông tin từ các bên thứ ba, hoặc khi tải xuống hay sử dụng các Ứng dụng Skylark trên thiết bị di động, thông tin về địa điểm, thông tin từ mạng xã hội Bên thứ ba nếu Khách hàng lựa chọn mạng xã hội để kết nối với Ứng dụng Skylark.

SỬ DỤNG THÔNG TIN:
Skylark sử dụng thông tin được mô tả trong Chính sách về Quyền riêng tư này (i) trong nội bộ, để phục vụ cho các mục đích sau đây:

(a) Để xử lý việc cung cấp dịch vụ, để cung cấp cho Khách hàng các sản phẩm hay dịch vụ Khách hàng yêu cầu từ Skylark, xử lý phần thanh toán.

(b) Để cải tiến và nâng cao trải nghiệm của Khách hàng trên Ứng dụng Skylark.

(c) Đánh giá việc sử dụng sản phẩm và dịch vụ trên Ứng dụng Skylark.

(d) Trao cho Khách hàng cơ hội tham gia vào các cuộc thi hay chương trình khuyến mãi.

(e) Phân tích tính hiệu quả của các nội dung.

(f) Đề xuất, giới thiệu về các bộ phim, chương trình truyền hình, quảng cáo mà Skylark cho rằng Khách hàng có thể quan tâm.

(g) Cá nhân hóa trải nghiệm trang trên Ứng dụng Skylark, đồng thời đánh giá số liệu thống kê về hoạt động của Skylark, chẳng hạn như thời gian Khách hàng ghé thăm, trang web nào giới thiệu Khách hàng đăng nhập vào đó…

Để bảo vệ thông tin không bị phá hoại một cách vô tình hay cố ý, khi chúng tôi xóa thông tin khỏi dịch vụ của Skylark, chúng tôi có thể không xóa ngay các bản sao còn lại từ máy chủ hay xóa bỏ thông tin từ hệ thống sao lưu của chúng tôi. Mỗi máy tính nối mạng đều được xác định bởi một chuỗi số gọi là "giao thức Internet" hay địa chỉ IP. Khi người dùng có một yêu cầu gửi đến máy chủ của Skylark trong khi truy cập vào trang, máy chủ sẽ nhận ra người thông qua địa chỉ IP đó. Điều này sẽ không ảnh hưởng gì đến những thông tin cá nhân của Khách hàng ngoài việc nhận ra một máy tính đang truy cập Ứng dụng Skylark. Skylark dùng thông tin này để xác lập thống kê về lượng truy cập toàn cục, và để xem có sự lạm dụng băng thông hay không nhằm phối hợp với các chính sách pháp luật ban hành về an ninh mạng.

ĐỐI TÁC ỨNG DỤNG XỬ LÝ THÔNG TIN CÁ NH N KHÁCH HÀNG:
Skylark có thể cung cấp thông tin cá nhân cho Đối tác Ứng dụng hiện hành. Việc Đối tác Ứng dụng sử dụng thông tin cá nhân của bạn phải tuân theo chính sách bảo mật riêng của Đối tác Ứng dụng - chứ không phải Chính sách về Quyền riêng tư này.

CHIA SẺ THÔNG TIN:
Thông tin cá nhân về người dùng của chúng tôi là một phần không thể thiếu trong hoạt động kinh doanh của chúng tôi. Chúng tôi thực hiện mọi biện pháp phòng ngừa thích hợp có thể để bảo mật thông tin cá nhân của Khách hàng. Chúng tôi không cho thuê hay bán thông tin cá nhân của Khách hàng cho bất kỳ ai (ngoại trừ việc chia sẻ thông tin của Khách hàng với Đối tác Ứng dụng hiện hành) trừ trường hợp theo quy định pháp luật hoặc theo các quy định trong Chính sách quyền riêng tư của Skylark. Chúng tôi chỉ chia sẻ thông tin cá nhân của Khách hàng như được mô tả bên dưới.

Đối tác Ứng dụng: Chúng tôi sẽ chia sẻ thông tin cá nhân của Khách hàng với Đối tác Ứng dụng hiện hành (xem phần "Đối tác Ứng dụng" ở trên).

Đại lý: Chúng tôi tuyển dụng các công ty và người khác để thay mặt chúng tôi thực hiện các nhiệm vụ và cần chia sẻ thông tin của bạn với họ để cung cấp sản phẩm hoặc dịch vụ cho Khách hàng. Trừ khi chúng tôi nói với bạn theo cách khác, các đại lý của Skylark không có bất kỳ quyền nào để sử dụng thông tin cá nhân mà chúng tôi chia sẻ với họ ngoài những gì cần thiết để hỗ trợ chúng tôi. Khách hàng đồng ý với việc chia sẻ thông tin cá nhân của chúng tôi cho các mục đích trên.

Chuyển nhượng Kinh doanh: Trong một số trường hợp, chúng tôi có thể chọn mua hoặc bán tài sản. Trong các loại giao dịch này, thông tin của Khách hàng thường là một trong những tài sản kinh doanh được chuyển giao. Hơn nữa, nếu Skylark hoặc về cơ bản là tất cả tài sản của nó đã được mua lại hoặc trong trường hợp không chắc rằng Skylark ngừng hoạt động hoặc phá sản, thông tin của người dùng sẽ là một trong những tài sản được bên thứ ba chuyển giao hoặc mua lại. Khách hàng xác nhận rằng việc chuyển giao như vậy có thể xảy ra và bất kỳ người mua lại Skylark nào cũng có thể tiếp tục sử dụng thông tin cá nhân của bạn như được quy định trong chính sách này.

Bảo vệ Skylark và những người khác: Chúng tôi có thể tiết lộ thông tin cá nhân khi chúng tôi tin tưởng thành thực rằng việc tiết lộ là cần thiết để tuân thủ luật pháp; thực thi hoặc áp dụng các điều kiện sử dụng và / hoặc các thỏa thuận khác của chúng tôi; và / hoặc bảo vệ quyền, tài sản, sự an toàn của Skylark, nhân viên của chúng tôi, người dùng của chúng tôi và / hoặc những người khác. Điều này bao gồm trao đổi thông tin với các công ty và tổ chức khác để chống gian lận và giảm rủi ro tín dụng.

Với sự đồng ý của Khách hàng: Ngoại trừ những điều đã nêu ở trên, Khách hàng sẽ được thông báo khi thông tin cá nhân của Khách hàng có thể bị chia sẻ với bên thứ ba và sẽ có thể ngăn chặn việc chia sẻ thông tin này.

Sự kiện bất khả kháng: Có thể có những nhân tố vượt ra ngoài tầm kiểm soát của Skylark dẫn đến việc Dữ liệu bị tiết lộ. Không có một hệ thống an ninh nào trên toàn thế giới có thể đảm bảo an toàn 100%. Do vậy, Skylark áp dụng mọi biện pháp có thể nhưng không chịu trách nhiệm bảo đảm Dữ liệu luôn được duy trì ở tình trạng hoàn hảo không bị tiết lộ. Khách hàng bằng việc truy cập Ứng dụng Skylark qua đây đồng ý với điều khoản này. Nhưng để tạo điều kiện cho Khách hàng dễ dàng truy cập vào tài khoản của mình và để giúp quản lý viên của Skylark, Skylark thực hiện công nghệ cho phép nhận ra Khách hàng là chủ tài khoản và cung cấp cho Khách hàng truy cập trực tiếp vào tài khoản của Khách hàng. Ngoài ra, Quý khách cũng có trách nhiệm giữ bí mật thông tin truy cập tài khoản của mình để hạn chế truy cập vào máy tính hoặc thiết bị của Khách hàng. Nếu có thể, các thiết bị công cộng hoặc các thiết bị dùng chung nên đăng xuất khi hoàn thành mỗi lần truy cập. Nếu Khách hàng bán hoặc trả lại một máy tính hoặc thiết bị cài sẵn Ứng dụng Skylark, Khách hàng cần đăng xuất và tắt các thiết bị trước khi làm như vậy. Nếu Khách hàng không duy trì tính bảo mật của mật khẩu hoặc thiết bị của Khách hàng, hoặc không thoát hoặc tắt điện thoại, người sử dụng tiếp theo có thể truy cập vào tài khoản của Khách hàng, bao gồm cả thông tin cá nhân và Dữ liệu của Khách hàng.

ỨNG DỤNG / TRANG WEB CỦA BÊN THỨ BA:
Ứng dụng Skylark có thể cho phép Khách hàng liên kết đến các ứng dụng hoặc trang web khác. Các ứng dụng / trang web của bên thứ ba đó không thuộc quyền kiểm soát của Skylark và các liên kết như vậy không cấu thành sự chứng thực của Skylark đối với các ứng dụng / trang web khác đó hoặc các dịch vụ được cung cấp thông qua chúng. Các thực tiễn về quyền riêng tư và bảo mật của ứng dụng / trang web của bên thứ ba được liên kết với Ứng dụng Skylark không được đề cập trong Chính sách về Quyền riêng tư này và Skylark không chịu trách nhiệm về quyền riêng tư hoặc các thực tiễn bảo mật hoặc nội dung của các trang web đó. Nói cách khác, Skylark từ chối mọi thông tin cá nhân bị rò rỉ từ các ứng dụng / trang web của bên thứ ba.

QUẢNG CÁO BÊN THỨ BA:
Ứng dụng Skylark có thể đăng quảng cáo và quảng cáo có thể bao gồm các đường dẫn tới các trang web khác. Cũng như nhiều website khác, Skylark thiết lập và sử dụng cookie để tìm hiểu thêm về cách Quý khách tương tác với nội dung của Skylark và giúp Skylark cải thiện trải nghiệm của Khách hàng khi sử dụng dịch vụ trên Ứng dụng Skylark.

BIÊN TẬP THÔNG TIN CÁ NH N:
Skylark cho phép Khách hàng truy cập thông tin sau về Khách hàng với mục đích xem và trong một số tình huống nhất định, cập nhật thông tin đó. Danh sách này có thể thay đổi trong trường hợp ứng dụng thay đổi.

Thông tin tài khoản và hồ sơ người dùng
Địa chỉ e-mail của người dùng (nếu có)
Số điện thoại (nếu có)
Tài khoản mạng xã hội liên kết hoặc thông tin hồ sơ mạng xã hội (nếu có)
Sở thích của người sử dụng
Dữ liệu ứng dụng cụ thể
CHÍNH SÁCH TRẺ EM:
Sản phẩm của chúng tôi có sẵn cho trẻ em dưới sự kiểm soát của cha mẹ. Skylark tạo ra một môi trường an toàn cho con em chúng ta thưởng thức nội dung giáo dục, âm nhạc và giải trí.

THỜI GIAN LƯU TRỮ VÀ XÓA DỮ LIỆU:
Skylark có thể lưu giữ thông tin của bạn trong khoảng thời gian cần thiết để cung cấp dịch vụ cho bạn. Trong trường hợp Skylark không cần thông tin của bạn để cung cấp dịch vụ cho bạn, Skylark chỉ giữ lại chừng nào Skylark có mục đích kinh doanh hợp pháp trong việc lưu giữ dữ liệu đó, bao gồm việc tuân thủ các nghĩa vụ pháp lý của Skylark, thực thi các thỏa thuận của Skylark, giải quyết tranh chấp và miễn là cần thiết cho việc thiết lập, thực hiện hoặc bảo vệ các khiếu nại pháp lý.

Cách yêu cầu xóa dữ liệu của bạn
Yêu cầu qua email:
Bạn có thể yêu cầu xóa dữ liệu của mình bất cứ lúc nào bằng cách liên hệ với chúng tôi theo địa chỉ Skylarkapp-support@Skylark.vn. Skylark sẽ đánh giá các yêu cầu đó theo từng trường hợp và sẽ gửi cho bạn xác nhận sau khi thông tin đã bị xóa.

Xóa khỏi Ứng dụng:
Trong Ứng dụng Skylark khi bạn đăng nhập vào tài khoản của mình, bạn sẽ có tùy chọn "Xóa tài khoản". Điều này sẽ xóa dữ liệu cá nhân của bạn.
Khởi chạy ứng dụng trên thiết bị di động > Đi tới "Tài khoản" > Chọn "Cài đặt chung" > Chọn "Xóa tài khoản" > Xác nhận yêu cầu xóa của bạn

Xin lưu ý: Khi tài khoản của bạn bị xóa, tất cả thông tin cá nhân và dữ liệu khác được liên kết với tài khoản đó cũng bị xóa.

CÁC THAY ĐỔI VỀ BÁO CÁO RIÊNG TƯ NÀY:
Skylark có thể sửa đổi Chính sách về Quyền riêng tư này tùy từng thời điểm mà không cần báo trước. Việc sử dụng thông tin chúng tôi thu thập bây giờ phải tuân theo Chính sách về Quyền riêng tư có hiệu lực tại thời điểm thông tin đó được sử dụng. Nếu chúng tôi thực hiện các thay đổi trong cách sử dụng thông tin cá nhân, chúng tôi sẽ thông báo cho Khách hàng bằng cách đăng thông báo trên Trang web của chúng tôi [chèn địa chỉ trang] hoặc gửi email cho Khách hàng. Người dùng bị ràng buộc bởi bất kỳ thay đổi nào đối với Chính sách về Quyền riêng tư khi họ sử dụng hoặc truy cập vào Ứng dụng Skylark sau khi những thay đổi đó được đăng lần đầu.

PHƯƠNG THỨC HỖ TRỢ:
Nếu Khách hàng có bất kỳ câu hỏi hoặc thắc mắc nào liên quan đến quyền riêng tư trên Trang web của chúng tôi, vui lòng gửi tin nhắn chi tiết cho chúng tôi theo địa chỉ email Skylarkapp-support@Skylark.vn. Chúng tôi sẽ cố gắng hết sức để giải quyết các mối quan tâm của Khách hàng một cách kịp thời.

ĐỒNG Ý CỦA KHÁCH HÀNG:
Bất kể có quy định nào trong Chính sách này, bằng việc sử dụng dịch vụ trên Ứng dụng Skylark, Khách hàng đồng ý cho phép Skylark ghi nhận, sử dụng và tiết lộ thông tin cá nhân của Khách hàng theo quy định và phù hợp với Chính sách này. Khi truy cập Ứng dụng Skylark, Khách hàng cam kết đã đọc toàn bộ, thừa nhận rằng đã hiểu và đồng ý tự nguyện tuân thủ Chính sách này cùng với Điều khoản sử dụng dịch vụ của Ứng dụng Skylark.



''',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
