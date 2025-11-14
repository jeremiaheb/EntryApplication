(function ($) {
  // Sums the numeric values of the given fields
  $.fn.sumValues = function () {
    return _.reduce(
      this.toArray(),
      function (sum, element) {
        return sum + parseFloat($(element).val() || "0");
      },
      0,
    );
  };

  // Sets the total-valid or total-invalid class based on whether the value is 100
  $.fn.setTotalValidClass = function () {
    return this.each(function () {
      const $this = $(this);
      if ($this.val() == "") {
        $this.removeClass("total-valid").removeClass("total-invalid");
      } else if ($this.val() == 100) {
        $this.removeClass("total-invalid").addClass("total-valid");
      } else {
        $this.removeClass("total-valid").addClass("total-invalid");
      }
    });
  };
})(jQuery);
