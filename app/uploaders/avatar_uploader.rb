class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  version :large do
    process :resize_to_fill => [500, 500]
  end

  def extension_white_list
    %w(jpg jpeg jpg gif png)
  end
end
