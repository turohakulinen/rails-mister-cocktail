class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient
  validates_associated :cocktail, :ingredient
  validates :cocktail, uniqueness: { scope: :ingredient }
end
