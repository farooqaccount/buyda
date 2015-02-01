class OrdersDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Order.count,
      iTotalDisplayRecords: orders.total_entries,
      aaData: data
    }
  end

private

  def data
      orders.map do |order|
      [
        link_to(order.id, order),
        h(order.user.user_name),
        h(order.order_status.name),
        h(order.created_at.strftime("%B %d %Y")),
        h(order.discounted_total)
        #h(product.released_on.strftime("%B %e, %Y"))
        
      ]
    end
  end

    def orders
        @orders ||= fetch_orders
  end

    def fetch_orders
        orders = Order.order("#{sort_column} #{sort_direction}")
        orders = orders.page(page).per_page(per_page)
    if params[:sSearch].present?
        orders = orders.where("id like :search or order_status.name like :search or user.user_name like :search or order.discounted_total like :search", search: "%#{params[:sSearch]}%")
    end
    orders
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
columns = %w[id user order_status created_at discounted_total]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

