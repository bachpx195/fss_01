class Admin::CategoriesController < AdminController
  before_action :authenticate_user!
  before_action :find_category, except: [:new, :create]

  def new
    @category = Category.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.categories.update_success"
    else
      flash[:danger] = t "admin.categories.delete_success"
    end
    redirect_to :back
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.categories.update_success"
    else
      flash[:success] = t "admin.categories.update_unsuccess"
    end
    redirect_to :back
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.categories.delete_success"
    else
      flash[:success] = t "admin.categories.delete_unsuccess"
    end
    redirect_to :back
  end

  private
  def category_params
    params.require(:category).permit :name, :category_group_id
  end

  def find_category
    @category_group = CategoryGroup.find_by id: params[:category_group_id]
    if @category_group.nil?
      flash[:success] = t "admin.category_group.category_group_not_found"
      redirect_to admin_root_path
    else
      @category = @category_group.categories.find_by id: params[:id]
      unless @category
        flash[:danger] = t "admin.categories.category_not_found"
        redirect_to admin_root_path
      end
    end
  end
end
