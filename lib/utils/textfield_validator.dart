class TextFieldValidator {
  static String? validator(String? text, String field) {
    if (text == null || text.isEmpty) {
      return "Please provide the $field";
    } else {
      return null;
    }
  }

  static String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please provide the price";
    }
    if (double.tryParse(value) == null) {
      return "Please enter a valid number";
    }

    if (double.tryParse(value)! <= 0) {
      return "Please enter a valid number greater than zero";
    }
    return null;
  }

  static String? imageUrlValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please provide the image url";
    }

    if (!value.startsWith("http") && !value.startsWith("https")) {
      return "Please provide the valid image url";
    }

    if (!value.endsWith(".png") &&
        !value.endsWith(".jpeg") &&
        !value.endsWith(".jpg")) {
      return "Please provide the valid image url";
    }
    return null;
  }
}
