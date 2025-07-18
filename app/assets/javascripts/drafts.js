$(function () {
  // The main function that serializes the form and sends it to the save draft endpoint.
  //
  // It is wrapped in _.throttle so it is called on the trailing edge at most
  // once in a 3 second window. More casually this means no matter how many
  // times the function is called within a 3 second window, the code will only
  // actually be executed once at the end of the window.
  //
  // The draft is therefore saved periodically and after things have "settled,"
  // but not so often as to flood the server with requests.
  var currentDraftRequest;
  const saveDraftThrottled = _.throttle(
    function (e) {
      let $target = $(e.target);
      let $form = $target.closest("form");

      let draftsURL = $form.data("drafts-url");
      if (!draftsURL) {
        return;
      }

      // Cancel any in flight requests.
      if (currentDraftRequest) {
        currentDraftRequest.abort();
        currentDraftRequest = null;
      }

      // While the form is submitting, drafts are suppressed. Otherwise, a draft
      // request could arrive after the request that saved the record. In that
      // case, a pending draft for a fully saved record could occur, possibly
      // leading to users duplicating records.`
      let suppressDrafts = $form.data("drafts-suppress");
      if (suppressDrafts) {
        return;
      }

      let params = $form.serializeArray();
      params.push({ name: "sequence", value: new Date().getTime() });
      params.push({
        name: "focused_dom_id",
        value: $(document.activeElement).attr("id"),
      });
      params.push({ name: "_method", value: "post" });

      $form.trigger("draft:beforeSend");

      currentDraftRequest = $.ajax({
        type: "POST",
        url: draftsURL,
        data: $.param(params),
        headers: {
          "X-CSRF-Token": $("meta[name='csrf-token']").attr("content"),
        },
        withCredentials: true,
        success: function (data, textStatus, jqXHR) {
          $form.trigger("draft:success", [data, textStatus, jqXHR]);
        },
        error: function (jqXHR, textStatus, errorThrown) {
          if (textStatus === "abort") {
            return;
          }

          $form.trigger("draft:error", [jqXHR, textStatus, errorThrown]);
        },
      });
    },
    3000,
    { leading: false },
  );

  const $formsWithDraftsURLs = $("form[data-drafts-url]");

  // Save drafts for forms where data-drafts-url is present as an attribute.
  const handleChange = function (e) {
    let $target = $(e.target);
    let $form = $target.closest("form");

    $form.trigger("draft:pending");

    return saveDraftThrottled(e);
  };
  $formsWithDraftsURLs.on("input", ":input", handleChange);
  // timeentry only fires 'change' for some reason
  $formsWithDraftsURLs.on("change", "input.is-timeEntry", handleChange);
  // select2 only fires 'change' events on the <select>
  $formsWithDraftsURLs.on("change", "select", handleChange);
  // Events fired by nested_form.js
  $formsWithDraftsURLs.on(
    "nested:fieldAdded, nested:fieldRemoved",
    handleChange,
  );

  $formsWithDraftsURLs.each(function () {
    const $form = $(this);

    // warnBeforeUnload will cause the browser to pop up a dialog warning the
    // user before they navigate away.
    const warnBeforeUnload = function (e) {
      e.preventDefault();
      e.returnValue = true;
    };

    // Trigger validation and cursor restoration for draft-enabled forms
    if ($form.data("draft-restored")) {
      $form.validate().form(); // trigger validation
      window.addEventListener("beforeunload", warnBeforeUnload);
    }
    if ($form.data("draft-focused-dom-id")) {
      $("#" + $form.data("draft-focused-dom-id")).focus();
    }

    // Once a draft is pending, periodically save it in the background
    // regardless of change events in case there were errors saving the previous
    // draft.
    let saveDraftInterval = undefined;
    $form.on(
      "draft:pending",
      _.once(function (e) {
        window.addEventListener("beforeunload", warnBeforeUnload);
        saveDraftInterval = setInterval(function () {
          saveDraftThrottled(e);
        }, 30 * 1000); // NOTE: delay must be longer than the throttle interval
      }),
    );

    // Suppress drafts while the form is submitting.
    $form.on("submit", function () {
      if (saveDraftInterval) {
        clearInterval(saveDraftInterval);
      }

      $form.data("drafts-suppress", true);
    });

    // Do not warn if draft is about to be saved or discarded.
    $form.on("submit", function (e) {
      window.removeEventListener("beforeunload", warnBeforeUnload);
    });
    $("a.discard-draft-link").on("ajax:success", function (e) {
      window.removeEventListener("beforeunload", warnBeforeUnload);
    });

    // Visualize draft saving progress
    $form.on("draft:pending", function (e) {
      $(".draft-progress .progress").removeClass("progress-striped active");
      $(".draft-progress .bar").hide();
      $(".draft-progress .bar.draft-pending").show();
    });
    $form.on("draft:beforeSend", function (e) {
      $(".draft-progress .progress").addClass("progress-striped active");
      $(".draft-progress .bar").hide();
      $(".draft-progress .bar.draft-saving").show();
    });
    $form.on("draft:success", function (e) {
      $(".draft-progress .progress").removeClass("progress-striped active");
      $(".draft-progress .bar").hide();
      $(".draft-progress .bar.draft-saved").show();
    });
    $form.on("draft:error", function (e) {
      $(".draft-progress .progress").removeClass("progress-striped active");
      $(".draft-progress .bar").hide();
      $(".draft-progress .bar.draft-pending").show();
    });
  });

  // After the draft is discarded, reload the page to empty out all fields and
  // start from scratch cleanly.
  $("a.discard-draft-link").on("ajax:success", function (e) {
    location.reload(true);
  });
});
