authorization do
        
        role :administrator do
            has_permission_on[:products, :categories, :manufacturers,:countries, :currencies, :languages, :length_classes, :order_statuses, :product_options, :return_actions, :return_reasons, :return_statuses, :stock_statuses, :weight_classes,:zones], :to => [:index, :show, :new, :edit, :update, :destroy]
        end
        
        role :customer do
            has_permission_on[:products, :categories], :to => [:index, :show]
        end
    end
