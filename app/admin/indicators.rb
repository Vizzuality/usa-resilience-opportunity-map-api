ActiveAdmin.register Indicator do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :slug
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :slug]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :category_id, :name, :description, :slug,
                :relevant, :labels, :legend_states, :legend_countries, :legend_title

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :category
      f.input :name
      f.input :description
      f.input :slug
      f.input :labels
      f.input :legend_states
      f.input :legend_countries
      f.input :legend_title

    end
    actions
  end
end
