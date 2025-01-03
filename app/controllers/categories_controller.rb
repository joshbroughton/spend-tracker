class CategoriesController < ApplicationController
  before_action :set_category, only: [ :edit, :update, :destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully created."
      redirect_to categories_path
    else
      flash[:alert] = "Error creating category: #{category.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category successfully updated."
      redirect_to categories_path
    else
      flash[:alert] = "Error updating category: #{category.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    uncategorize_transactions
    @category.destroy
    flash[:notice] = "Category deleted and associated transactions uncategorized."
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def uncategorize_transactions
    Transaction.where(category_id: @category.id).update_all(category_id: nil)
  end
end
