class Admin::CategoryGroupsController < AdminController
  before_action :authenticate_user!
  before_action :find_category_group, except: [:create, :new, :index]

  def index
    @category_groups = CategoryGroup.all
  end

  def new
    @category_group = CategoryGroup.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @category_group = CategoryGroup.new category_params
    if @category_group.save
      flash[:success] = t "admin.category_group.create_success"
    else
      flash[:danger] = t "admin.category_group.create_fail"
    end
    redirect_to :back
  end

  def show
    @categories = @category_group.categories
  end

  def edit
  end

  def update
    if @category_group.update_attributes category_params
      flash[:success] = t "admin.category_group.update_success"
    else
      flash[:success] = t "admin.category_group.update_unsuccess"
    end
    redirect_to :back
  end

  def destroy
    if @category_group.destroy
      flash[:success] = t "admin.category_group.delete_success"
    else
      flash[:success] = t "admin.category_group.delete_unsuccess"
    end
    redirect_to :back
  end

  private
  def category_params
    params.require(:category_group).permit :name
  end

  def find_category_group
    @category_group = CategoryGroup.find_by id: params[:id]
    unless @category_group
      flash[:success] = t "admin.category_group.category_group_not_found"
      redirect_to admin_root_path
    end
  end
end
