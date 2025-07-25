# Silence some currently-benign deprecation warnings until USWDS addresses them.
Rails.application.config.sass.silence_deprecations = [
  "mixed-decls",
  "global-builtin",
]
