class Notifications < ActionMailer::Base
  default from: "support@fhqpro.com"
    
    def new_order(order)
        @order = order
        @greeting = "Hello #{order.user.user_name}"
        mail to: "#{order.user.email}"
        
        #attachments.inline['banner.jpeg'] = File.read("#{Rails.root}/public/frontend/layout/img/logos/Ologo-blue.png")
        attachments.inline['banner.jpeg'] = File.read("#{Rails.root}/public/frontend/layout/img/logos/logo-corp-blue.png")
        mail(to: order.user.email, subject: 'Order Confirmation')
    end
    
    def update_order(order)
        @order = order
        @greeting = "Hello #{order.user.user_name}"
        mail to: "#{order.user.email}"
    end
end
