ActiveAdmin.register Provider do
  menu parent: "Compras", label: "Proveedores"

  filter :cuit, label: "CUIT"
  filter :name, label: "Razon social"
  filter :cuit, label: "Direccion"

  index title: 'Proveedores' do
    column ("CUIT") { |provider| provider.cuit }
    column ("Razon social") { |provider| provider.name }
    column ("Direccion") { |provider| provider.address }

    default_actions
  end

  form do |f|
    f.inputs "Informacion de proveedor" do
      f.input :cuit, label: "CUIT", hint: "Formato: xx-xxxxxxxx-xx"
      f.input :name, label: "Razon social"
      f.input :address, label: "Direccion"
    end

    f.actions
  end

  show title: "Informacion de proveedor" do
    attributes_table do
      row ("Razon social") { |provider| provider.name }
      row ("CUIT") { |provider| provider.cuit }
      row ("Direccion") { |provider| provider.address }
    end
  end
end
