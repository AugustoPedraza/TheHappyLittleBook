ActiveAdmin.register Cart, as: "Compras" do

  controller do
    def scoped_collection
      end_of_association_chain.purchases
    end
  end

  filter :user
  filter :updated_at, label: "Fecha"

  actions :index, :show

  index do
    column ("Fecha") { |purchase| purchase.purchase_date.strftime("%d - %B - %Y") }
    column "Items", :items_count
    column("Total") { |purchase| "$ #{purchase.total}" }
    column("Usuario") { |purchase| purchase.user.name }

    default_actions
  end

  show do
    attributes_table do
      row ("Fecha") { |purchase| purchase.purchase_date.strftime("%d - %B - %Y") }
      row ("Items") { |purchase| purchase.items_count }
      row("Total") { |purchase| "$ #{purchase.total}" }
      row("Usuario") { |purchase| purchase.user.name }
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
                <th>Titulo</th>
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
