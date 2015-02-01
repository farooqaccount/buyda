class Currency < ActiveRecord::Base
    
    validates :title, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true
    validates :decimal_place, numericality: true, length: {in: 1..2}, if: "decimal_place.present?"
     validates :value, :numericality => true,
                        :format => { #:with => /\A\d+(?:\.\d{0,10})?\z/ }, if: "value.present?"
                                     :with => /\A\d+(\.|,)?\d{0,10}?\z/}, if: "value.present?"
    #validates_format_of :decimal_value_field, :with => /\d{0,10}\.\d{2}/
    #:with => /\A\d{0,5}\.\d{0,10}\z/
    validate :is_default_true_is_duplicate
    
        def is_default_true_is_duplicate
            if is_default.present? && is_default?
                if Currency.where(is_default: true).count > 0
                    errors.add(:base,"Default Currency already present.")
                end
            end
        end
    
    
end
