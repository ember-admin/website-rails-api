class ProductImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  version :large do
    process :resize_to_fill => [1000, 1000]
  end

  def extension_white_list
    %w(jpg jpeg jpg gif png)
  end
   
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
end
