class Admin::LengthClassesController < Admin::AdminController
    
    def index
        @length_classes = LengthClass.all
    end
    
    def new
        @length_class = LengthClass.new
    end
    
    def create
        @length_class = LengthClass.new(length_class_params)
        if @length_class.save
            redirect_to length_class_path(@length_class.id), notice: "Successfully added the length class"
        else
            render :new
        end
    end
    
    def show
        @length_class = LengthClass.find(params[:id])
    end
    
    def edit
        @length_class = LengthClass.find(params[:id])
    end
    
    def update
        @length_class = LengthClass.find(params[:id])
        if @length_class.update(length_class_params)
            redirect_to length_class_path(@length_class.id), notice: "Successfully updated the length class"
        else
            render :edit
        end
    end
    
    def destroy
        @length_class = LengthClass.find(params[:id])
        if @length_class.delete
            redirect_to length_classes_path, notice: "Successfully deleted the length class"
        else
            render :show
        end
    end
        
        private
        
        def length_class_params
            params.require(:length_class).permit(:title, :unit, :value)
        end
end
