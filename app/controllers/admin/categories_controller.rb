class Admin::CategoriesController < Admin::AdminController
    
    filter_access_all :all # This will allow us to mention all the actions in the authorization rules rb
    #The below will be used only if there are normal restful operations
    #filter_resource_access # This is Declarative Authorization method which needs to be called in each and every controller
    
  def index
      @categories = Category.all
       respond_to do |format|
        format.html
          #format.json { render :json => @categories.map(&:attributes) }
           format.json { render :json => @categories.where("name like ? ","%#{params[:q]}%") }
      end
  end
    
    def new
        @category = Category.new
#         @categories_select = Category.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s 
#       }.sort {|x,y| x.ancestry <=> y.ancestry 
#       }.map{ |c| ["-" * (c.depth - 1) + c.name,c.id] 
#       }.unshift(["-- none --", nil])
        
        @categories_select = Category.arrange_as_array({:order => 'name'}, @category.possible_parents)
    end
    
    def create
        @category = Category.new(categories_params)
        if @category.save
            redirect_to category_path(@category.id), notice: "Successfully Added The Category"
        else
            render :new
        end
    end
        
    def show
        @category = Category.find(params[:id])
    end
    
    def edit
        @category = Category.find(params[:id])
    end
    
    def update
        @category = Category.find(params[:id])
        if @category.update(categories_params)
            redirect_to category_path(@category.id), notice: "Successfully updated the category"
        else
            render :edit
        end
    end
    
    def destroy
        @category = Category.find(params[:id])
        if @category.delete
            redirect_to categories_path, notice: "Successfully deleted the category"
        else
            render :show
        end
    end
    
    private
    
    def categories_params
        params.require(:category).permit(:name, :title, :description, :is_active, :meta_title, :meta_description, :meta_keyword, :parent_id)
    end
    
end
