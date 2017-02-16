# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

ingre_has = JSON.parse(open('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read)

ingre_has["drinks"].each do |i|
  Ingredient.create(name: i["strIngredient1"])
end

descriptions = ['heaps', 'some', 'lots', '4cl', '8cl', '2dl']

10.times do
  cocktail = Cocktail.new(name: Faker::Beer.name)
  cocktail.save!
  (2..7).to_a.sample.times do
    ing = Ingredient.all.sample
    dose = Dose.new(description: descriptions.sample)
    dose.cocktail = cocktail
    dose.ingredient = ing
    dose.save!
  end
end
