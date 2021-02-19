ActiveAdmin.register Geometry do

  before_action :jsonfy, only: [:update]

  #permit_params :geom, :name, :description, :gid, :location_type, :parent_id,
                #:state_fp, :county_fp, :tract_ce, :geojson, :properties, :bbox

  controller do
    def permitted_params
      params.permit!
    end
    def jsonfy
      params[:geometry][:bbox] = JSON.parse params[:geometry][:bbox]
    end
  end

  filter :id, as: :string, label: "ID"
  filter :name, as: :string, label: "Name"
  filter :gid, as: :string, label: "GID"
  filter :location_type, as: :string

  index do
    selectable_column
      column :id
      column :name
      column :description
      column :gid
      column :location_type
      column :parent_id
      column :state_fp
      column :county_fp
      column :bbox
      column :tract_ce
    actions
  end
  form do |f|
    f.semantic_errors
    div do
      f.inputs "Options" do
        f.input :name
        f.input :description
        f.input :gid
        f.input :location_type
        f.input :parent_id
        f.input :state_fp
        f.input :county_fp
        f.input :properties, as: :text
        f.input :bbox, as: :text
        f.input :tract_ce
      end
    end
    div do
      f.actions
    end
  end

end
