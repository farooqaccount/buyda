class Admin::CurrenciesController < Admin::AdminController
    
    def index
        @currencies = Currency.all
    end
    
    def new
        @currency = Currency.new
    end
    
    def create
        @currency = Currency.new(currency_params)
        if @currency.save
            redirect_to currency_path(@currency.id), notice: "Successfully added the currency"
        else
            render :new
        end
        
    end
    
    def show
        @currency = Currency.find(params[:id])
    end
    
    def edit
        @currency = Currency.find(params[:id])
    end
    
    def update
        @currency = Currency.find(params[:id])
        if @currency.update(currency_params)
            redirect_to currency_path(@currency.id), notice: "Successfully updated the currency"
        else
            render :edit
        end
    end
    
    def destroy
        @currency = Currency.find(params[:id])
        if @currency.delete
            redirect_to currencies_path, notice: "Successfully deleted the currency"
        else
            render :show
        end
    end
    
    private
    
    def currency_params
        params.require(:currency).permit(:title, :code, :symbol_left, :symbol_right, :decimal_place, :value, :status, :is_default)
    end
end
