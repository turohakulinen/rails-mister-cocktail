class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
    #@dose.cocktail = @cocktail
  end

  def create
    @dose = Dose.new(dose_params);
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.ingredient = Ingredient.find(params[:dose][:id])
    if @dose.save
      redirect_to edit_cocktail_path(@dose.cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to edit_cocktail_path(@cocktail)
  end
  private
  def dose_params
    params.require(:dose).permit(:description)
  end
end
