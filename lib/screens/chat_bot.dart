import 'package:chat_document/utils/app_bar.dart';
import 'package:chat_document/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../utils/colors.dart';
import '../utils/widgets.dart';

class ChatBot extends StatelessWidget {
  ChatBot({super.key});
  static const routeName = '/chat-bot';
  final TextEditingController _inputController = TextEditingController();
  final List<Message> messages = [
    Message(text: 'Trí tuệ nhân tạo là gì?', isUser: true),
    Message(
        text:
            'Trí tuệ nhân tạo (AI) là một lĩnh vực của khoa học máy tính tập trung vào việc tạo ra các hệ thống có khả năng thực hiện các nhiệm vụ mà nếu là con người thực hiện, sẽ đòi hỏi trí tuệ. Những hệ thống này bao gồm các ứng dụng như nhận dạng giọng nói, hình ảnh, xử lý ngôn ngữ tự nhiên, và ra quyết định tự động. AI đang ngày càng phát triển và có ảnh hưởng lớn đến nhiều lĩnh vực khác nhau như y tế, giáo dục, và giao thông.',
        isUser: false),
    Message(text: 'Các ứng dụng của trí tuệ nhân tạo là gì?', isUser: true),
    Message(
        text:
            'Các ứng dụng của trí tuệ nhân tạo (AI) rất đa dạng và được áp dụng rộng rãi trong nhiều lĩnh vực khác nhau. Dưới đây là một số ứng dụng nổi bật:Y tế: AI được sử dụng để phân tích dữ liệu y tế, giúp chẩn đoán bệnh, dự đoán diễn biến bệnh tật, và đề xuất phương pháp điều trị. Các hệ thống AI có thể giúp phát hiện sớm các dấu hiệu của bệnh qua việc phân tích hình ảnh y khoa hoặc theo dõi các chỉ số sinh học của bệnh nhân.Giáo dục: AI hỗ trợ cá nhân hóa quá trình học tập, giúp giáo viên theo dõi tiến trình học của học sinh và đưa ra các gợi ý học tập phù hợp. Các hệ thống dạy học tự động có thể điều chỉnh bài giảng và bài tập dựa trên trình độ và phong cách học tập của từng học sinh.Giao thông: AI đóng vai trò quan trọng trong việc phát triển xe tự lái và các hệ thống điều khiển giao thông thông minh. Những hệ thống này có khả năng phân tích tình trạng giao thông, dự đoán các tình huống nguy hiểm, và đưa ra các quyết định lái xe an toàn.Thương mại: AI cải thiện trải nghiệm mua sắm trực tuyến thông qua việc đề xuất sản phẩm, tối ưu hóa giá cả, và quản lý kho hàng. AI cũng có thể dự đoán nhu cầu của khách hàng dựa trên hành vi mua sắm trước đây và các xu hướng thị trường.Giải trí: AI thay đổi cách chúng ta thưởng thức nội dung giải trí, từ việc gợi ý phim, nhạc, sách dựa trên sở thích cá nhân của người dùng, đến việc tạo ra các nhân vật và kịch bản phức tạp trong game, mang đến trải nghiệm chơi game chân thực hơn.',
        isUser: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(
        context,
        "Chat bot",
        AssetConstants.bot,
        IconButton(
          onPressed: () {
            // showUpdateBotDialog(context, "", "", "");
          },
          icon: const Icon(
            Icons.add,
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(text: "Chat"),
                    Tab(text: "Ngữ cảnh"),
                  ],
                  unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                  labelStyle: Theme.of(context).textTheme.headlineLarge,
                ),
                BoxEmpty.sizeBox20,
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView.builder(
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  return Align(
                                    alignment: message.isUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: message.isUser
                                              ? Colors.blue
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          message.text,
                                          style: TextStyle(
                                            color: message.isUser
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _inputController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText: 'Nhập nội dung...',
                                      hintStyle: const TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.lightGrey,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton.filled(
                                  onPressed: () {},
                                  icon: Icon(Icons.send),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            // final order = completedOrder[index];
                            return Text("ABC");
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Message {
//   final String text;
//   final bool isUser;

//   Message({
//     required this.text,
//     required this.isUser,
//   });
// }
