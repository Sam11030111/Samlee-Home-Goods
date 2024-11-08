ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :image

  # Specify the filters you want
  filter :name
  filter :price
  filter :stock
  filter :category
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock
    column :category
    column :image do |product|
      if product.image.attached?
        image_tag(url_for(product.image), size: "50x50") # Display a small thumbnail
      end
    end
    column "Orders" do |product|
      product.orders.map(&:id).join(", ") # Display the order names
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :category
      row :image do |product|
        if product.image.attached?
          image_tag(url_for(product.image), size: "100x100")
        end
      end
      row "Orders" do |product|
        product.orders.map(&:id).join(", ") # Display the order names
      end
    end
  end
end