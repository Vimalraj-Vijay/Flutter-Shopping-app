// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/utils/textfield_validator.dart';

void main() async {
  group('validateTitleDescriptionTextField', () {
    test(
        'given title value is null when validator is called then it returns a error message',
        () async {
      // given
      var value;

      // when
      var result = TextFieldValidator.validator(value, "title");

      // then
      expect(result, "Please provide the title");
    });

    test(
        'given description value is null when validator is called then it returns a error message',
        () async {
      // given
      var value;

      // when
      var result = TextFieldValidator.validator(value, "description");

      // then
      expect(result, "Please provide the description");
    });

    test(
        'given title value is empty when validator is called then it returns a error message',
        () async {
      // given
      var value = "";

      // when
      var result = TextFieldValidator.validator(value, "title");

      // then
      expect(result, "Please provide the title");
    });

    test(
        'given description value is empty when validator is called then it returns a error message',
        () async {
      // given
      var value = "";

      // when
      var result = TextFieldValidator.validator(value, "description");

      // then
      expect(result, "Please provide the description");
    });

    test(
        'given title/description value is not null and empty when validator is called then it returns a null',
        () async {
      // given
      var value = "title/description";

      // when
      var result = TextFieldValidator.validator(value, "");

      // then
      expect(result, null);
    });
  });

  group('validatePriceField', () {
    test(
        'given price value is null when priceValidator is called then it returns a error message',
        () async {
      // given
      var value;

      // when
      var result = TextFieldValidator.priceValidator(value);

      // then
      expect(result, "Please provide the price");
    });

    test(
        'given price value is empty when priceValidator is called then it returns a error message',
        () async {
      // given
      var value = "";

      // when
      var result = TextFieldValidator.priceValidator(value);

      // then
      expect(result, "Please provide the price");
    });

    test(
        'given price value is alphabetical text when priceValidator is called then it returns a error message',
        () async {
      // given
      var value = "abc";

      // when
      var result = TextFieldValidator.priceValidator(value);

      // then
      expect(result, "Please enter a valid number");
    });

    test(
        'given price value is alphabetical text when priceValidator is called then it returns a error message',
        () async {
      // given
      var value = "abc";

      // when
      var result = TextFieldValidator.priceValidator(value);

      // then
      expect(result, "Please enter a valid number");
    });

    test(
        'given price value is equal or less than 0 when priceValidator is called then it returns a error message',
        () async {
      // given
      var value = "0";

      // when
      var result = TextFieldValidator.priceValidator(value);

      // then
      expect(result, "Please enter a valid number greater than zero");
    });

    test(
        'given price value is valid amount when priceValidator is called then it returns null',
        () async {
      // given
      var value = "100";

      // when
      var result = TextFieldValidator.priceValidator(value);

      // then
      expect(result, null);
    });
  });

  group('validateImageUrlField', () {
    test(
        'given image url value is null when imageUrlValidator is called then it returns a error message',
        () async {
      // given
      var value;

      // when
      var result = TextFieldValidator.imageUrlValidator(value);

      // then
      expect(result, "Please provide the image url");
    });

    test(
        'given image url value is empty when imageUrlValidator is called then it returns a error message',
        () async {
      // given
      var value = "";

      // when
      var result = TextFieldValidator.imageUrlValidator(value);

      // then
      expect(result, "Please provide the image url");
    });

    test(
        'given image url value not valid at start when imageUrlValidator is called then it returns a error message',
        () async {
      // given
      var value =
          "s://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg";

      // when
      var result = TextFieldValidator.imageUrlValidator(value);

      // then
      expect(result, "Please provide the valid image url");
    });

    test(
        'given image url value not valid at end when imageUrlValidator is called then it returns a error message',
        () async {
      // given
      var value =
          "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280";

      // when
      var result = TextFieldValidator.imageUrlValidator(value);

      // then
      expect(result, "Please provide the valid image url");
    });

    test(
        'given image url value valid when imageUrlValidator is called then it returns null',
        () async {
      // given
      var value =
          "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg";

      // when
      var result = TextFieldValidator.imageUrlValidator(value);

      // then
      expect(result, null);
    });
  });
}
