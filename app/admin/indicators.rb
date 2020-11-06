ActiveAdmin.register Indicator do
  permit_params :category_id, :parent_id, :name, :description, :slug, :relevant,
                :labels, :legend_states, :legend_countries, :legend_tracts, :legend_title

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
      f.input :labels
      f.input :legend_states
      f.input :legend_countries
      f.input :legend_tracts
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
