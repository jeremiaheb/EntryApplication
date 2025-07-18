// Custom jquery-validator methods that may be reused by many forms

$.validator.addMethod(
  "fieldID",
  function (value, element) {
    return this.optional(element) || /^\d{5}[a-zA-Z]$/i.test(value);
  },
  "FieldID is wrong format",
);

$.validator.addMethod(
  "lettersonly",
  function (value, element) {
    return this.optional(element) || /[a-zA-Z]+$/.test(value);
  },
  "Only one letter",
);

$.validator.addMethod("before", function (value, element, params) {
  return value < $(params).val();
});

$.validator.addMethod("lessThanEqualTo", function (value, element, params) {
  return Number(value) <= Number($(params).val());
});
$.validator.addMethod("greaterThan", function (value, element, params) {
  return value > $(params).val();
});
$.validator.addMethod("greaterThanEqualTo", function (value, element, params) {
  return Number(value) >= Number($(params).val());
});
