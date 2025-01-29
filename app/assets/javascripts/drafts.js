$(function() {
  var currentDraftRequest;
  const saveDraftDebounced = _.debounce(function(e) {
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

    currentDraftRequest = $.ajax({
      type: "PUT",
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

        // Retry. Rely on debounce to coalesce multiple calls into one retry.
        saveDraftDebounced(e);
      },
    });
  }, 2500);

  const $formsWithDraftsURLs = $("form[data-drafts-url]");
  $formsWithDraftsURLs.on("blur change", ":input", saveDraftDebounced)

  // After the draft is discarded, reload the page to empty out all fields and
  // start from scratch cleanly.
  $("a.discard-draft-link").on("ajax:complete", function(e) {
    location.reload(true);
  });

  $formsWithDraftsURLs.each(function() {
    const $form = $(this);
    if ($form.data("draft-restored")) {
      $form.validate().form(); // trigger validation
    }
    if ($form.data("draft-focused-dom-id")) {
      $("#" + $form.data("draft-focused-dom-id")).focus();
    }
  });
});
