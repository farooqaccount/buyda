class StockStatus < ActiveRecord::Base
    validates :name, presence: true, length: {in: 2..20}
    
    validate :is_default_true_is_duplicate
    
        def is_default_true_is_duplicate
            if is_default.present? && is_default?
                if StockStatus.where(is_default: true).count > 0
                    errors.add(:is_default, ": Default Stock Status already present.")
                end
            end
        end
end
