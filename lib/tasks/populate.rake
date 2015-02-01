namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
      [Manufacturer, Category, User, Product, Order, OrderProduct].each(&:delete_all)
    
      Manufacturer.populate 2 do |manufacturer|
          manufacturer.name = Populator.words(1..3).titleize
          manufacturer.poc = Populator.words(1..3).titleize
          manufacturer.website = Populator.words(1..3).titleize
          #previous_cat = ""
#           Category.populate 20 do |category|
#               category.name = Populator.words(1..3).titleize
#               category.description = Populator.words(1..15).titleize
#               category.is_active = true
#               category.title = Populator.words(1..5).titleize
#               category.ancestry = previous_cat.empty? ? "New Cat" : previous_cat
#               previous_cat = category.name
#                User.populate 10 do |person|
#                    person.user_name    = Faker::Name.name
#                   person.email   = Faker::Internet.email
#                   person.phone_number   = Faker::PhoneNumber.phone_number
#                   person.first_name    = Faker::Name.first_name
#                   person.last_name    = Faker::Name.last_name
#                       Product.populate 5 do |product|
#                           product.category_id = category.id
#                           product.manufacturer_id = manufacturer.id
#                           product.name = Populator.words(1..5).titleize
#                           product.description = Populator.words(2..10)
#                           product.price = [4.99, 19.95, 100]
#                           product.quantity = 100
#                           product.in_stock = "Yes"
#                           product.user_id = person.id
#                           product.created_at = 2.years.ago..Time.now
#                           Order.populate 1 do |order|
#                               order.user_id = person.id
#                               order.order_status_id = 1
#                               order.invoice_no = rand(500...500000)
#                               order.total = rand(100...1000)
#                               order.discounted_total = rand(100...1000)
#                               order.name = person.user_name
#                               order.address = Faker::Address.street_address
#                               order.payment_type = "CreditCard"
#                               OrderProduct.populate 1 do |orderProduct|
#                                   orderProduct.order_id = order.id
#                                   orderProduct.product_id = product.id
#                                   orderProduct.user_id = person.id
#                                   orderProduct.quantity = 1
#                                   orderProduct.discounted_price = rand(100...1000)
#                               end
                          #end
                          
                      #end
               #end
          #end
       end
    
  end
end