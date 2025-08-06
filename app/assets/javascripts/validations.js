// Custom jquery-validator methods that may be reused by many forms

$.validator.addMethod(
  "requiredIfEnabled",
  function (value, element, params) {
    function isEnabled(e) {
      // the element and all of its parents must be :visible
      // inspiration: http://remysharp.com/2008/10/17/jquery-really-visible/
      return e.is(":enabled");
    }

    if (isEnabled($(element))) {
      // call the "required" method
      return $.validator.methods.required.call(
        this,
        $.trim(element.value),
        element,
      );
    }

    return true;
  },
  $.validator.messages.required,
);

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
$.validator.addMethod("after", function (value, element, params) {
  return value > $(params).val();
});

$.validator.addMethod("lessThan", function (value, element, params) {
  return Number(value) < Number($(params).val());
});
$.validator.addMethod("lessThanEqualTo", function (value, element, params) {
  return Number(value) <= Number($(params).val());
});
$.validator.addMethod("greaterThan", function (value, element, params) {
  return Number(value) > Number($(params).val());
});
$.validator.addMethod("greaterThanEqualTo", function (value, element, params) {
  return Number(value) >= Number($(params).val());
});
