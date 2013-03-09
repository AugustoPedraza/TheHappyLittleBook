ActiveAdmin.register Cart, as: "Orden de compra" do
  menu parent: "Compras"
  config.per_page = 10


  controller do
    def scoped_collection
      end_of_association_chain.purchases
    end

  end

  filter :provider
  filter :updated_at, label: "Fecha"
  filter :calculated_total , as: :numeric_range, label: "Monto de la compra"

  index do
    column ("Fecha")    { |purchase| purchase.purchase_date.strftime("%d - %B - %Y") }
    column "Items",     :items_count
    column("Total")     { |purchase| "$ #{purchase.total}" }
    column("Proveedor") { |purchase| purchase.provider.name }

    default_actions
  end

  show do
    attributes_table do
      row ("Fecha") { |purchase| purchase.purchase_date.strftime("%d - %B - %Y") }
      row ("Items") { |purchase| purchase.items_count }
      row("Total") { |purchase| "$ #{purchase.total}" }
      row("Proveedor") { |purchase| purchase.provider.name }
      row("compra") do |purchase|
        table = "
          <br/>
          <br/>
          <br/>
          <br/>
          <table border='1px' class= 'table' style= 'margin-bottom: -10px'>
            <tbody>
              <tr>
                <th>Unid.</th>
                <th>ISBN13(Titulo)</th>
                <th>P.U</th>
                <th>Subtotal</th>
              </tr>"

        purchase.cart_items.each do |item|
          table <<
            " <tr>
                <td align= 'center'>
                  #{item.quantity}
                </td>
                <td align= 'left'>
                  #{item.book.isbn13 + item.book.title}
                </td>
                <td>
                  #{item.price}
                </td>
                <td align= 'right'>
                  #{item.subtotal}
                </td>
              </tr>"
        end

        table << "</tr>
        </tbody></table>"

        table.html_safe

       end

    end
  end

  form do |f|
    f.inputs "Informacion de la compra" do
      f.input :purchase_date, label: "Fecha", as: :date_select
      f.input :provider, label: "Proveedor"
      f.input :is_purchase, as: :hidden, value: true

      f.has_many :cart_items do |cart_item|
        cart_item.inputs do "Nueva linea"
          cart_item.input :quantity, label: 'Items'
          cart_item.input :price,    label: 'Precio'
          cart_item.input :book,     label: 'Book'

        end
      end
    end

    f.actions
  end
end
