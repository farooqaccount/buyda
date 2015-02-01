class PaymentDetailsController < ApplicationController
    
    def index
        @payment_details = PaymentDetail.all
    end
    
    def new
        @payment_detail = PaymentDetail.new
    end
    
    def create
        @payment_detail = PaymentDetail.new(payment_detail_params)
        if @payment_detail.save
            redirect_to payment_detail_path(@payment_detail.id), notice: "Successfully create the payment detail"
        else
            render :new
        end
    end
    
    def show
        @payment_detail = PaymentDetail.find(params[:id])
    end
    
    def edit
        @payment_detail = PaymentDetail.find(params[:id])
    end
    
    def update
        @payment_detail = PaymentDetail.find(params[:id])
        if @payment_detail.update
            redirect_to payment_detail_path, notice: "Successfully updated the payment detail"
        else
            render :edit
        end
    end
    
    def destroy
         @payment_detail = PaymentDetail.find(params[:id])
        if @payment_detail.delete
            redirect_to payment_details_path, notice: "Successfully deleted the payment detail"
        else
            render :show
        end
    end
    
    private
    
    def payment_detail_params
        params.require(:payment_detail).permit(:property_id,:payment_date,:payment_type,:payment_amount,:payment_mode,:payment_details)
    end
end
