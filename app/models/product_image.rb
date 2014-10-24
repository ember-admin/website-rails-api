class ProductImage < Asset
  mount_uploader :data, ProductImageUploader
end