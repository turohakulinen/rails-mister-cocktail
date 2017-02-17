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
  img_url = "http://www.thecocktaildb.com/images/ingredients/" + URI.escape(i["strIngredient1"]) +"-Small.png"
  ing = Ingredient.new(name: i["strIngredient1"])
  ing.remote_photo_url = img_url
  ing.save!
end


10.times do
  cocktail_has_big = JSON.parse(open('http://www.thecocktaildb.com/api/json/v1/1/random.php').read)
  cocktail_has = cocktail_has_big["drinks"][0]
  cocktail = Cocktail.new(name: cocktail_has["strDrink"], instruction: cocktail_has["strInstructions"])
  cocktail.remote_photo_url = cocktail_has["strDrinkThumb"]
  if cocktail.save
    i = 1
    loop do
      ing_name = cocktail_has["strIngredient" + i.to_s]
      break if ing_name.length == 0
      ing = Ingredient.where("name like ?", ing_name)[0]
      if !ing
        ing = Ingredient.new(name: ing_name)
        ing.save!
      end
      dose = Dose.new(description: cocktail_has["strMeasure" + i.to_s])
      dose.cocktail = cocktail
      dose.ingredient = ing
      dose.save!
      i += 1
    end
  end
end
