import 'dart:convert';

import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wgnrr/api/const.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wgnrr/models/client/chats/chat_room/appointment.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:wgnrr/widget/app_button.dart';
import 'package:wgnrr/widget/app_input_text.dart';

class Add extends StatefulWidget {
  var username;
  var doctor;
  var client;
  Add(
      {super.key,
      required this.client,
      required this.doctor,
      required this.username});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  File? _imageFile;
  Future addPic() async {
    final uri = Uri.parse('${murl}message/message_image_write.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['username'] = widget.username.toString();
    request.fields['doctor'] = widget.doctor.toString();
    request.fields['comment'] = caption.text.toString();
    request.fields['part'] = '1'.toString();
    var pic = await http.MultipartFile.fromPath("image", _imageFile!.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      caption.clear();
      setState(() {
        get_comments();
      });
      Navigator.pop(context);
    }
  }

  var comment;
  Future get_comments() async {
    const url = '${murl}message/message.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "client": widget.client.toString(),
      "doctor": widget.doctor.toString()
    });
    if (response1.statusCode == 200) {
      if (mounted) setState(() {});
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController caption = TextEditingController();
  var category;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Appointment(
                            client: widget.client,
                            doctor: widget.doctor,
                          )));
                },
                icon: Icon(Icons.notifications))
          ],
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: AppText(
            txt: 'Chat Room',
            color: Colors.white,
            size: 15,
          ),
          backgroundColor: HexColor('#742B90'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_imageFile != null) ...[
                  Image.file(
                    _imageFile!,
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                        onPress: () => _pickImage(ImageSource.camera),
                        label: 'Take a Photo',
                        borderRadius: 15,
                        textColor: Colors.white,
                        bcolor: Colors.purple),
                    AppButton(
                        onPress: () => _pickImage(ImageSource.gallery),
                        label: 'Choose from Gallery',
                        borderRadius: 15,
                        textColor: Colors.white,
                        bcolor: Colors.purple),
                  ],
                ),
                AppInputText(
                  labelColor: Colors.white,
                  textfieldcontroller: caption,
                  isemail: false,
                  fillcolor: Colors.white,
                  obscure: false,
                  label: 'Caption',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 50,
                  child: AppButton(
                      onPress: () {
                        addPic();
                      },
                      label: 'Save',
                      borderRadius: 25,
                      textColor: Colors.white,
                      bcolor: Colors.purple),
                ),
              ],
            )));
  }
}
