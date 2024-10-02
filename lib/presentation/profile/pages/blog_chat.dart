import 'package:flutter/material.dart';
import 'clan.dart';
import 'pullic.dart'; // Đảm bảo đường dẫn đúng đến file public.dart

class BlogChat extends StatefulWidget {
  @override
  _BlogChatState createState() => _BlogChatState();
}

class _BlogChatState extends State<BlogChat> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  // Câu hỏi và câu trả lời mẫu
  final Map<String, String> _faq = {
    'Bạn có thể cho tôi biết thời gian mở cửa không?':
        'Chúng tôi mở cửa từ 9 giờ sáng đến 10 giờ tối.',
    'Sản phẩm nào đang được khuyến mãi?':
        'Chúng tôi hiện đang có chương trình khuyến mãi cho sản phẩm X.',
    'Bạn có thể giúp tôi đặt hàng không?':
        'Chắc chắn rồi! Bạn hãy cung cấp thông tin sản phẩm bạn muốn đặt.',
  };

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        String userMessage = _messageController.text;
        messages.add('Bạn: $userMessage');

        // Kiểm tra nếu có câu trả lời cho câu hỏi
        if (_faq.containsKey(userMessage)) {
          messages.add('Bot: ${_faq[userMessage]}');
        } else {
          messages.add('Bot: Xin lỗi, tôi không hiểu câu hỏi của bạn.');
        }
        _messageController.clear();
      });
    }
  }

  // Hàm để hiển thị lựa chọn nhóm chat
  void _showChatOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn nhóm chat',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.group, color: Colors.blue),
                title: Text('Nhóm chat của tôi',
                    style: TextStyle(color: Colors.blue)),
                onTap: () {
                  Navigator.of(context).pop(); // Đóng dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClanChat()), // Chuyển đến ClanChat
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.public, color: Colors.green),
                title: Text('Nhóm chat toàn cầu',
                    style: TextStyle(color: Colors.green)),
                onTap: () {
                  Navigator.of(context).pop(); // Đóng dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PublicChat()), // Chuyển đến PublicChat
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: _showChatOptions,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.white], // Màu nền
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 3,
                    child: ListTile(
                      title: Text(messages[index]),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 12, 2, 2),
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
