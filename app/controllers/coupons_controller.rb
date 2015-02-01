class CouponsController < ApplicationController
    
    def index
        @coupons = Coupon.all
    end
    
    def new
        @coupon = Coupon.new
    end
    
    def create
        @coupon = Coupon.new(coupon_params)
        if @coupon.save
            redirect_to coupon_path(@coupon.id), notice: "Successfully add the coupon"
        else
            render :new
        end
        
    end
    
    def show
        @coupon = Coupon.find(params[:id])
    end
    
    def edit
         @coupon = Coupon.find(params[:id])
    end
    
    def update
         @coupon = Coupon.find(params[:id])
        if @coupon.update(coupon_params)
            redirect_to coupon_path(@coupon.id), notice: "Successfully added the coupon"
        else
            render :edit
        end
    end
    
    def destroy
        @coupon = Coupon.find(params[:id])
        if @coupon.delete
            redirect_to coupons_path, notice: "Successfully deleted the product"
        else
            render :show
        end
    end
    
    private
    
    def coupon_params
        params.require(:coupon).permit(:coupon_code, :start_date, :end_date, :usage, :coupon_type, :discount,:total_amount,:user_logged_in,:uses_per_coupon,:uses_per_user,:product_tokens,:manufacturer_tokens,:category_tokens, product_coupons_attributes:[:id,:product_id],manufacturer_coupons_attributes:[:id,:manufacturer_id],category_coupons_attributes:[:id,:category_id])
    end
end
