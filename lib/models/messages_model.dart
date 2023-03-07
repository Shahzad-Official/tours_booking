class MessagesModel {
  String? message;
  String? senderId;
  String? receiverId;
  String? id;
  MessagesModel({
    this.id,
    this.message,
    this.receiverId,
    this.senderId,
  });
  MessagesModel.fromJson(Map json) {
    id = json["id"];
    message = json['message'];
    senderId = json['senderId'];
    receiverId = json["receiverId"];
  }
}
