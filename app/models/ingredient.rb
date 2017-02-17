class Ingredient < ApplicationRecord
  has_many :doses
  validates :name, uniqueness: true, presence: true
  #validates :photo, presence: true
  mount_uploader :photo, IngredienPhotoUploader
end
