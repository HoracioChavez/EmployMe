class Administrator::CategoriesController < AdminsController
  before_action :lookup_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)

    if @category.save
      flash.notice = "A new category: '#{@category.title}' was successfully created"
      redirect_to administrator_categories_path
    else
      format.html { render :new, notice: 'Fill in all of the fields before submitting'}
    end

  end

  def edit
  end

  def update
    @category.update(category_params)

    if @category.save
      flash.notice = "Category: '#{@category.title}' has been updated"
      redirect_to administrator_categories_path
    else
      format.html { render :edit, notice: 'Fill in all of the fields before submitting'}
    end
  end


  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to administrator_categories_path, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def category_params
    params.require(:category).permit(:title,
                                     :description)
  end

  def lookup_category
    @category = Category.find(params[:id])
  end

end
