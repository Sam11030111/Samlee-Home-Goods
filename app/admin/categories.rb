ActiveAdmin.register Category do
  permit_params :name

  # Specify the filters you want
  filter :name
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
    end
  end
end

