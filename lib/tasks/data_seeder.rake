namespace :db do
  desc "Erase and fill database"
    task :data_seeder => :environment do
        require 'faker'
        
#         10.times{
#             Manufacturer.create(:name => [*('A'..'Z')].sample(8).join,:poc => [*('A'..'Z')].sample(8).join, :website => [*('A'..'Z')].sample(8).join)
#             }
        
    
#         20.times{
#             Category.create(:name => [*('A'..'Z')].sample(8).join,:title => [*('A'..'Z')].sample(8).join, :description => [*('A'..'Z')].sample(8).join, :is_active => true)
#            }
        
#         User.delete_all
#         20.times{
#             User.create!(:user_name => Faker::Name.first_name,:email => "#{Faker::Name.first_name}"+"@gmail.com", :phone_number => 1234567890, :first_name => Faker::Name.first_name,:last_name => Faker::Name.last_name,:password => "syedfarooq")
#            }
        
#         man_ids = Manufacturer.all.map(&:id)
#         cat_ids = Category.all.map(&:id)
#         user_ids = User.all.map(&:id)
        
#         100.times{
#             Product.create!(:name => [*('A'..'Z')].sample(8).join,:title => [*('A'..'Z')].sample(8).join,:description => [*('A'..'Z')].sample(8).join ,:price => rand(10...1000),:quantity => rand(5...25),:in_stock => "Yes",:created_at => rand(2.years.ago..Time.now),:manufacturer_id => rand(man_ids[0]..man_ids.length),:category_id => rand(cat_ids[0]..cat_ids.length),:user_id => rand(user_ids[0]..user_ids.length))   
#          }

        #         Order.delete_all
        user_ids = User.all.map(&:id)
        1000.times{
            Order.create(:user_id => user_ids.sample(random: user_ids[0]...user_ids.length),:order_status_id => 1,:invoice_no => rand(500...500000),:total => rand(100...1000),:discounted_total => rand(100...1000),:name => Faker::Name.first_name,:address => Faker::Address.street_address,:payment_type => "CreditCard",:created_at => rand(2.years.ago..Time.now))
            }
        
#         OrderProduct.delete_all
#         order_ids = Order.all.map(&:id)
#         product_ids = Product.all.map(&:id)
#         user_ids = User.all.map(&:id)
#         3000.times{
            
#             OrderProduct.create!(:order_id => rand(order_ids[0]...order_ids.length),:product_id => rand(product_ids[0]...product_ids.length), :user_id => rand(user_ids[0]...user_ids.length), :quantity => 1 ,:discounted_price => rand(10...1000), :created_at => rand(2.years.ago...Time.now))
#             }
        
#         Trackable.delete_all
#         user_ids = User.all.map(&:id)
#         product_ids = Product.all.map(&:id)
#         (1...20).to_a.each_with_index do |i|
#             Trackable.create!(:user_id => user_ids[i],:product_id => product_ids[i])
#         end
#         (1...20).to_a.each_with_index do |i|
#             Trackable.create!(:user_id => user_ids[i],:product_id => product_ids[i+20])
#         end
#         (1...20).to_a.each_with_index do |i|
#             Trackable.create!(:user_id => user_ids[i],:product_id => product_ids[i+40])
#         end
    end
end