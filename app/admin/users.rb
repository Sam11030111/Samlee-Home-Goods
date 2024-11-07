ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :password, :isAdmin, :image

  # Specify the filters you want
  filter :first_name
  filter :last_name
  filter :email
  filter :isAdmin
  filter :created_at

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :isAdmin
    column :image do |user|
      if user.image.attached?
        image_tag(url_for(user.image), size: "50x50") # Display a small thumbnail
      end
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :isAdmin
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :isAdmin
      row :image do |user|
        if user.image.attached?
          image_tag(url_for(user.image), size: "100x100")
        end
      end
    end
  end
end

