ActiveAdmin.register Cart, as: "Compras" do

  controller do
    def scoped_collection
      end_of_association_chain.sales
    end
  end

  filter :user
  filter :updated_at, label: "Fecha"

  actions :index, :show

  index do
    column ("Fecha") { |sale| sale.sale_date.strftime("%d - %B - %Y") }
    column "Items", :items_count
    column("Total") { |sale| "$ #{sale.total}" }
    column("Usuario") { |sale| sale.user.name }

    default_actions
  end

  show do
    attributes_table do
      row ("Fecha") { |sale| sale.sale_date.strftime("%d - %B - %Y") }
      row ("Items") { |sale| sale.items_count }
      row("Total") { |sale| "$ #{sale.total}" }
      row("Usuario") { |sale| sale.user.name }
      row("compra") do |sale|
        table = "
          <br/>
          <br/>
          <br/>
          <br/>
          <table border='1px' class= 'table' style= 'margin-bottom: -10px'>
            <tbody>
              <tr>
                <th>Unid.</th>
                <th>Titulo</th>
                <th>P.U</th>
                <th>Subtotal</th>
              </tr>"

        sale.cart_items.each do |item|
          table <<
            " <tr>
                <td align= 'center'>
                  #{item.quantity}
                </td>
                <td align= 'left'>
                  #{item.book.full_name}
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
end
