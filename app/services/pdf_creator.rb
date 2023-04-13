class PdfCreator
  def initialize(order_params)
    @order = order_params[:order]
  end

  def create_pdf
    @pdf = Prawn::Document.new(
      :page_size => 'A4')
  
    @pdf.text "Order Details", size: 20, style: :bold, align: :center
  
    @pdf.move_down 20
    @pdf.text "Order ID: #{@order.id}"
    @pdf.text "Order Date: #{@order.created_at.strftime("%B %d, %Y at %I:%M %p")}"
  
    @pdf.move_down 20
    @pdf.text "Products Ordered", size: 16, style: :bold
    table_data = [["Name", "Price", "Quantity", "Total Price"]]
    @order.order_items.each do |item|
      table_data << [item.description, item.price, item.quantity, item.price ]
    end
    @pdf.table table_data, header: true, position: :center, width: 500
    @pdf.move_down 20

    @pdf.text "Total Price: $#{@order.order_items.sum { |item| item.price }}", size: 18, style: :bold, align: :center

		@pdf
    rescue ActiveRecord::RecordNotUnique => e
     # handle duplicate entry
    end
  end
