$(function() {
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
  const saveDraftThrottled = _.throttle(function(e) {
    let $target = $(e.target);
    let $form = $target.closest("form");
    let draftsURL = $form.data("drafts-url");

    if (!draftsURL) {
      return;
    }

    if (currentDraftRequest) {
      currentDraftRequest.abort();
      currentDraftRequest = null;
    }

    let params = $form.serializeArray();
    params.push({ name: "sequence", value: (new Date()).getTime() });
    params.push({ name: "focused_dom_id", value: $(document.activeElement).attr("id") });
    params.push({ name: "_method", value: "PUT" });

    currentDraftRequest = $.ajax({
      type: "POST",
      url: draftsURL,
      data: $.param(params),
      headers: {
        "X-CSRF-Token": $("meta[name='csrf-token']").attr("content"),
      },
      withCredentials: true,
      success: function(data, textStatus, jqXHR) {
        $form.trigger("draft:success", [data, textStatus, jqXHR]);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        if (textStatus === "abort") {
          return;
        }

        $form.trigger("draft:error", [jqXHR, textStatus, errorThrown]);

        // Retry. Rely on throttle to coalesce multiple calls into one retry.
        saveDraftThrottled(e);
      },
    });
  }, 3000, { leading: false });

  // Save drafts for forms where data-drafts-url is present as an attribute.
  const $formsWithDraftsURLs = $("form[data-drafts-url]");
  $formsWithDraftsURLs.on("blur change", ":input", saveDraftThrottled)

  // Trigger validation and cursor restoration for draft-enabled forms
  $formsWithDraftsURLs.each(function() {
    const $form = $(this);
    if ($form.data("draft-restored")) {
      $form.validate().form(); // trigger validation
    }
    if ($form.data("draft-focused-dom-id")) {
      $("#" + $form.data("draft-focused-dom-id")).focus();
    }
  });

  // After the draft is discarded, reload the page to empty out all fields and
  // start from scratch cleanly.
  $("a.discard-draft-link").on("ajax:complete", function(e) {
    location.reload(true);
  });
});
