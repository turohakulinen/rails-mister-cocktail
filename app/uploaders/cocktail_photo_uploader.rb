# encoding: utf-8

class CocktailPhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
