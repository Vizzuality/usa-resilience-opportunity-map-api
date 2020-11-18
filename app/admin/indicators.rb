ActiveAdmin.register Indicator do
  permit_params :category_id, :parent_id, :name, :description, :slug, :relevant,
                :labels_raw, :legend_states_raw, :legend_countries_raw, :legend_tracts_raw, :legend_title

  filter :name
  filter :parent_id, as: :select

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :category
      f.input :parent_id
      f.input :name
      f.input :description
      f.input :slug
      f.input :labels_raw
      f.input :legend_states_raw
      f.input :legend_countries_raw
      f.input :legend_tracts_raw
      f.input :legend_title
    end
    f.actions
  end

  index do
    column :id
    column :category
    column :parent_id
    column :slug
    column :name
    column :description
    column :labels
    column :legend_states
    column :legend_countries
    column :legend_tracts
    column :legend_title

    actions
  end
end
