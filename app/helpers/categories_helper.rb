module CategoriesHelper
    def get_category_siblings
       # category = Category.find(id)
        categories = ""
        if category.siblings.present?
            category.siblings.each do |page|
                categories = categories << page.name
            end
        else
            categories = category.name
        end
    end
end
