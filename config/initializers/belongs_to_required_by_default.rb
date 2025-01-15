# This application was upgraded from a version prior to Rails 5.2
#
# In Rails 5.2, `belongs_to` associations became required by default (an
# implicit `optional: false`). This application has several cases where
# `belongs_to` associations are allowed to be nil by default.
#
# TODO: Audit the application for these cases, add an explicit `optional: true`
# if it's really required and remove this file so that the new behavior can be a
# default.
Rails.application.config.active_record.belongs_to_required_by_default = false
