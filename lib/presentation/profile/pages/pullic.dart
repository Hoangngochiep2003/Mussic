import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class PublicChat extends StatefulWidget {
  @override
  _PublicChatState createState() => _PublicChatState();
}

class _PublicChatState extends State<PublicChat> {
  final List<Map<String, String>> members = [
    {"name": "Alice", "country": "🇺🇸 Mỹ"},
    {"name": "Carlos", "country": "🇪🇸 Tây Ban Nha"},
    {"name": "Keiko", "country": "🇯🇵 Nhật Bản"},
    {"name": "Raj", "country": "🇮🇳 Ấn Độ"},
    {"name": "Lara", "country": "🇧🇷 Brazil"},
  ];

  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [];
  Timer? _timer;
  bool _isAutoReplying = false;
  ScrollController _scrollController = ScrollController();

  final List<String> randomResponses = [
    "Thật tuyệt vời! 😍🎉🌟",
    "Mình rất đồng ý với bạn! 😊👍💖",
    "Nghe có vẻ thú vị! 🤔✨🎵",
    "Bài hát đó mình cũng thích! 🎶🙌😍",
    "Chúng ta nên nghe thử cùng nhau! 🎤👯‍♂️💿",
    "Âm nhạc luôn kết nối mọi người! ❤️🌈🎧",
    "Mình không thể chờ đợi để nghe bài mới! ⏳😃🔥",
    "Tâm trạng mình thật tốt khi nghe nhạc! 🎉😄🎶",
    "Chúng ta có thể làm một buổi nghe nhạc! 💿🎊👫",
    "Cảm giác như mình đang ở trong một buổi hòa nhạc! 🎤🎉🎸",
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  void _loadInitialMessages() {
    messages.addAll([
      "🇺🇸 Alice: Chào mọi người! Mình vừa nghe bài 'Cơn Mưa Ngang Qua', thật sự rất hay! 😊🎶🎉",
      "🇪🇸 Carlos: Mình cũng thích bài đó! Sơn Tùng thật sự có tài năng! 😍🎤🌟",
      "🇯🇵 Keiko: Ồ, mình nghe được một số bài hát của Sơn Tùng! Có ai biết bài nào khác hay không? 🤔💭✨",
      "🇮🇳 Raj: 'Chạy Ngay Đi' là một bài cực hay. MV cũng rất đẹp! 🌟📽️😍",
      "🇧🇷 Lara: Đúng rồi! Bài đó rất hấp dẫn! Mình còn thích 'Nơi Này Có Anh' nữa. 💖🎶🌈",
      "🇺🇸 Alice: Mình nghe nói Sơn Tùng sắp phát hành bài mới, có ai biết thông tin gì không? 📅📰🔍",
      "🇪🇸 Carlos: Mình cũng đã nghe như vậy! Hy vọng nó sẽ bùng nổ! 💥🎉🤩",
      "🇯🇵 Keiko: Không thể chờ đợi được! Mình sẽ theo dõi để không bỏ lỡ. ⏳👀🎧",
      "🇮🇳 Raj: Âm nhạc của anh ấy thật sự rất đặc biệt và có cá tính riêng. 🎵💫😍",
      "🇧🇷 Lara: Thật sự là vậy! Cảm giác như âm nhạc của anh ấy nói lên tâm tư của giới trẻ. 🎤❤️🌟",
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add('Bạn: ${_messageController.text} 😊🎤💬');
        String randomResponse = _getRandomResponse();
        messages.add(randomResponse);
        _messageController.clear();
        _scrollToBottom();
      });
    }
  }

  String _getRandomResponse() {
    final random = Random();
    int index = random.nextInt(randomResponses.length);
    
    // Lấy một người và quốc gia ngẫu nhiên
    Map<String, String> randomMember = members[random.nextInt(members.length)];
    return "${randomMember['country']} ${randomMember['name']}: ${randomResponses[index]}";
  }

  void _startAutoReply() {
    if (!_isAutoReplying) {
      _isAutoReplying = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          String randomResponse = _getRandomResponse();
          messages.add(randomResponse);
          _scrollToBottom();
        });
      });
    }
  }

  void _stopAutoReply() {
    if (_isAutoReplying) {
      _isAutoReplying = false;
      _timer?.cancel();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _showMemberOptions(String memberName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Để làm nền trong suốt
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.teal[800], // Màu nền của bottom sheet
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Chọn tùy chọn cho $memberName',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Khoảng cách giữa tiêu đề và các mục
              GestureDetector(
                onTap: () {
                  // Xử lý thêm bạn bè ở đây
                  Navigator.pop(context);
                  _showSnackBar('Thêm bạn bè với $memberName');
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.teal[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Thêm bạn bè với $memberName',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Xử lý mời vào nhóm ở đây
                  Navigator.pop(context);
                  _showSnackBar('Mời $memberName vào nhóm');
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.teal[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Mời $memberName vào nhóm',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.teal[600],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nhóm Trò Chuyện Công Khai - Âm Nhạc',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(_isAutoReplying ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              _isAutoReplying ? _stopAutoReply() : _startAutoReply();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[300]!, Colors.teal[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Khi nhấn vào tin nhắn
                      String message = messages[index];
                      RegExp exp = RegExp(r"^(.+?):");
                      Match? match = exp.firstMatch(message);
                      if (match != null) {
                        String memberName = match.group(0)!.replaceAll(':', '');
                        _showMemberOptions(memberName);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.teal[500],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.white),
                    onPressed: () {
                      // Xử lý tải tệp
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.photo, color: Colors.white),
                    onPressed: () {
                      // Xử lý tải ảnh
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        filled: true,
                        fillColor: Colors.teal[200]?.withOpacity(0.7), // Màu mờ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
