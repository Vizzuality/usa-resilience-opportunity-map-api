ActiveAdmin.register Geometry do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :geom, :name, :description, :gid, :location_type, :parent_id, :state_fp, :county_fp, :geojson, :properties, :bbox
  #
  # or
  #
  # permit_params do
  #   permitted = [:geom, :name, :description, :gid, :location_type, :parent_id, :state_fp, :county_fp, :geojson, :properties, :bbox]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :geom, :name, :description, :gid, :location_type, :parent_id,
                :state_fp, :county_fp, :tract_ce, :geojson, :properties, :bbox
end
