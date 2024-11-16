ActiveAdmin.register Province do
    permit_params :name, :gst_rate, :pst_rate
  
    # Specify the filters you want
    filter :name
    filter :created_at
  
    index do
      selectable_column
      id_column
      column :name
      column :created_at
      column :gst_rate
      column :pst_rate
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :gst_rate
        f.input :pst_rate
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :name
        row :gst_rate
        row :pst_rate
      end
    end
end