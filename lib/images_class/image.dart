// ignore_for_file: camel_case_types, non_constant_identifier_names

class Image_Class {
  int text_amount;
  String image_url;
  Image_Class({required this.text_amount, required this.image_url});

  void update_data(int n, String url) {
    image_url = url;
    text_amount = n;
  }
}
