ActiveAdmin.register Order do
  permit_params :status, :total_price, :user_id

  # Specify the filters you want
  filter :user
  filter :status
  filter :total_price
  filter :created_at

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :total_price
    column :created_at
    column :products do |order|
      order.products.map(&:name).join(', ') # Show product names
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.map { |user| ["#{user.id}", user.id] }
      f.input :status, as: :select, collection: ['pending', 'completed', 'shipped']
      f.input :total_price
      f.input :products, as: :select, multiple: true, collection: Product.all.map { |product| [product.name, product.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :status
      row :total_price
      row :products do |order|
        order.products.map(&:name).join(', ') # Show product names
      end
    end
  end
end

