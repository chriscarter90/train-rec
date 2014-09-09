CarrierWave.configure do |config|
  case Rails.env
  when 'development'
    config.storage = :file
  when 'test'
    config.storage = :file
    # Make sure we aren't doing any image processing for tests.
    config.enable_processing = false
  else
    carrierwave_settings = YAML.load_file(Rails.root.join('config', 'carrierwave.yml'))[Rails.env]
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => carrierwave_settings["aws_access_key_id"],
      :aws_secret_access_key  => carrierwave_settings["aws_secret_access_key"],
      :region                 => carrierwave_settings["region"]
    }

    config.fog_directory  = [carrierwave_settings["aws_bucket_name"], carrierwave_settings["fog_directory"]].join('/')
    config.fog_public     = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end

