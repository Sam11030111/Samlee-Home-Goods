ActiveAdmin.register Review do
  permit_params :rating, :comment, :user_id, :product_id

  # Specify the filters you want
  filter :user
  filter :product
  filter :rating
  filter :created_at

  index do
    selectable_column
    id_column
    column :user
    column :product
    column :rating
    column :comment
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.map { |user| ["#{user.id}", user.id] }
      f.input :product
      f.input :rating
      f.input :comment
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :product
      row :rating
      row :comment
    end
  end
end