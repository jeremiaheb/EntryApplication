// public/javascripts/rails.validations.custom.js

// The validator variable is a JSON Object
// The selector variable is a jQuery Object
window.clientSideValidations.validators.local['fieldid'] = function(element, options) {
  // Your validator code goes in here
  if (!/\d\d\d\d[A-Z]/.test(element.val())) {
    // When the value fails to pass validation you need to return the error message.
    // It can be derived from validator.message
    return options.message;
  }
}
