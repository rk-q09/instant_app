if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
    :provider               => 'AWS',
    :region                 => 'us-east-2',
    :aws_access_key_id      => 'AKIAJOVDZ2MQR5L4WI4C',
    :aws_secret_access_key  => '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'
    }
    config.fog_directory = 'railsinstantapp'
  end
end
