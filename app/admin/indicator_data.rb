ActiveAdmin.register IndicatorDatum do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :hazard_value, :geometry_id, :indicator_id, :absolute_value, :normalized_value, :range
  #
  # or
  #
  # permit_params do
  #   permitted = [:hazard_value, :geometry_id, :indicator_id, :absolute_value, :normalized_value, :range]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :category_id, :hazard_value, :geometry_id, :indicator_id, :absolute_value, :normalized_value, :range
end
