class Admin::LanguagesController < Admin::AdminController
    
    def index
        @languages = Language.all
    end
    
    def new
        @language = Language.new
    end
    
    def create
        @language = Language.new(language_params)
        if @language.save
            redirect_to language_path(@language.id), notice: "Successfully added the language"
        else
            render :new
        end
    end
    
    def show
        @language = Language.find(params[:id])
    end
    
    def edit
        @language = Language.find(params[:id])
    end
    
    def update
        @language = Language.find(params[:id])
        if @language.update(language_params)
            redirect_to language_path(@language.id), notice: "Successfully updated the language"
        else
            render :edit
        end
    end
    
    def destroy
        @language = Language.find(params[:id])
        if @language.delete
            redirect_to languages_path, notice: "Successfully deleted the language"
        else
            render :show
        end
    end
        
        private
        
        def language_params
            params.require(:language).permit(:name, :code, :locale, :directory, :filename, :sort_order, :status, :is_default)
        end
    
end
