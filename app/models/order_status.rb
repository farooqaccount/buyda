class OrderStatus < ActiveRecord::Base
    has_many :order_histories,dependent: :destroy
    has_many :orders, :through => :order_histories
    
    validates :name, presence: true, length: {in: 2..20}
    
    validate :is_default_true_is_duplicate
    
    validate :check_if_default, on: [:destroy]
    
        def is_default_true_is_duplicate
            if is_default.present? && is_default?
                if OrderStatus.where(is_default: true).count > 0
                    errors.add(:is_default, ": Default Order Status already present.")
                end
            end
        end
    
    def check_if_default
        if is_default.present? && is_default?
           # if OrderStatus.where(is_default: true).count == 1
                errors.add(:is_default, " Default record cannot be deleted.")
                return false
           # end
            #errors[:base] << "Default record cannot be deleted."
        end
    end
end
