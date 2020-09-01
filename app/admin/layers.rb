ActiveAdmin.register Layer do

  permit_params :category_id, :name, :layer_type, :source,
                :render, :legend_config

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :category
      f.input :name
      f.input :layer_type
      f.input :source, as: :text
      f.input  :render, as: :text
      f.input  :legend_config, as: :text

    end
    actions
  end
end
