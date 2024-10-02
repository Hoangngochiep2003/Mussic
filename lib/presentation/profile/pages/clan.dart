import 'dart:async'; // Thêm dòng này để sử dụng Timer
import 'package:flutter/material.dart';

class ClanChat extends StatefulWidget {
  @override
  _ClanChatState createState() => _ClanChatState();
}

class _ClanChatState extends State<ClanChat> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Danh sách thành viên
  List<String> members = [
    "🎤 Minh",
    "🎶 An",
    "🎧 Lan",
    "🎸 Hưng",
    "🎻 Mai",
  ];

  // Danh sách tin nhắn
  List<String> messages = [];

  // Danh sách các câu nói bàn luận
  List<String> discussionTopics = [
    "Mình nghĩ tiết mục vừa rồi của Sơn Tùng thật tuyệt vời! Ai đồng ý không? 🌟",
    "Đúng vậy! Mình rất thích cách anh ấy thể hiện cảm xúc qua bài hát. ❤️",
    "Tiết mục có những hiệu ứng ánh sáng rất đẹp mắt! Đúng là một nghệ sĩ tài năng! 🎆",
    "Mọi người thấy bài 'Chạy Ngay Đi' hôm nay thế nào? Quá hay phải không? 🎶",
    "Sơn Tùng thật sự biết cách kết nối với khán giả, mình cảm nhận được sự nhiệt huyết của anh ấy! 🎤",
  ];

  // Khởi tạo Timer
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoReply();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add('${members[0]}: ${_messageController.text}');
        _messageController.clear();
        _scrollToBottom();
      });
    }
  }

  void _startAutoReply() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) { // Giảm thời gian xuống còn 1 giây
      setState(() {
        // Randomly choose a member to send a discussion message
        String member = members[(messages.length % members.length)];
        String topic = discussionTopics[(messages.length % discussionTopics.length)];
        messages.add('$member: $topic');
        _scrollToBottom(); // Cuộn xuống tin nhắn mới
      });
    });
  }

  void _scrollToBottom() {
    // Cuộn đến cuối ListView
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhóm Fan Nhạc Sơn Tùng', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white], // Màu nền
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Đặt controller cho ListView
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(messages[index], style: TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
              // Thêm chức năng ghi âm ở đây
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Nhập tin nhắn...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Giảm chiều cao
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              // Thêm chức năng gửi file ở đây
            },
          ),
        ],
      ),
    );
  }
}
