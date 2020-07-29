# frozen_string_literal: true

JSONAPI.configure do |config|
  # built in paginators are :none, :offset, :paged
  config.default_paginator = :paged
  config.default_page_size = 50
  config.maximum_page_size = 30_000
  config.resource_cache = Rails.cache
  config.always_include_to_one_linkage_data = false

  # Metadata
  # Output record count in top level meta for find operation
  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :record_count
  config.top_level_meta_include_page_count = true
  config.top_level_meta_page_count_key = :page_count


  # Removes the top level links
  config.top_level_links_include_pagination = false

  # Exception Handling
  config.exception_class_whitelist = [ActiveRecord::RecordNotFound]
end

