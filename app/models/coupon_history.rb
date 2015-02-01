class CouponHistory < ActiveRecord::Base
    belongs_to :coupon
    belongs_to :order
    
    after_save :update_history  

    private

    def update_history
          #count = self.user.training_sessions.sum(:duration)
          #points = count / 6 if count >= 1
          #self.user.update_attribute(:points, points)        
    end
end
