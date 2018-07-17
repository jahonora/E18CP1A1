ActiveAdmin.register Product do
  permit_params :name, :price, :user_id

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :user
    actions
  end

  filter :name
  filter :price

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :user
    end
    f.actions
  end

end
