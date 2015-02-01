class Review < ActiveRecord::Base
    belongs_to :product
    
    attr_reader :product_token
    
    def product_token=(ids)
        self.product_id = id
      end
end
