# encoding: utf-8

class IngredienPhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'jpg'

  version :standard do
    resize_to_fit 150, 150
  end
end
