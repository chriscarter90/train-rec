BeValidAsset::Configuration.display_invalid_content = true
BeValidAsset::Configuration.markup_validator_host = 'validator.unboxedconsulting.com'
BeValidAsset::Configuration.css_validator_host = 'validator.unboxedconsulting.com'
BeValidAsset::Configuration.enable_caching = true
BeValidAsset::Configuration.cache_path = Rails.root.join('tmp', 'be_valid_asset_cache')
BeValidAsset::Configuration.markup_modifiers = [[/^.*http-equiv.*$/, '']]
