class Admin::WeightClassesController < Admin::AdminController
    
    def index
        @weight_classes = WeightClass.all
    end
    
    def new
        @weight_class = WeightClass.new
    end
    
    def create
        @weight_class = WeightClass.new(weight_class_params)
        if @weight_class.save
            redirect_to weight_class_path(@weight_class.id), notice: "Successfully added the weight class"
        else
            render :new
        end
    end
    
    def show
        @weight_class = WeightClass.find(params[:id])
    end
    
    def edit
        @weight_class = WeightClass.find(params[:id])
    end
    
    def update
        @weight_class = WeightClass.find(params[:id])
        if @weight_class.update(weight_class_params)
            redirect_to weight_class_path(@weight_class.id), notice: "Successfully updated the weight class"
        else
            render :edit
        end
    end
    
    def destroy
        @weight_class = WeightClass.find(params[:id])
        if @weight_class.delete
            redirect_to weight_classes_path, notice: "Successfully deleted the weight class"
        else
            render :show
        end
    end
        
        private
        
        def weight_class_params
            params.require(:weight_class).permit(:title, :unit, :value)
        end
    
end
