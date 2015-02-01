class Language < ActiveRecord::Base
    
    validates :name, presence: true, uniqueness: true    
    validates :locale, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true
    validates :directory, presence: true
    validates :filename, presence: true
    validates :status, presence: true
    #validates :is_default, presence: true
    validates :sort_order, presence: true, uniqueness: true
    validate :is_default_true_is_duplicate
    
    def is_default_true_is_duplicate
        if is_default.present? && is_default?
            if Language.where(is_default: true).count > 0
                errors.add(:is_default, ": Default language already present.")
            end
        end
        
        
    end
end
