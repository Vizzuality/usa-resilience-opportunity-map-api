class CreateMvService
  def initialize

  end

  def call
    indicator_data_pivot
  end

  private

  def indicator_data_pivot
    query =
      <<~SQL
DROP MATERIALIZED VIEW IF EXISTS indicator_data_pivot;
CREATE MATERIALIZED VIEW indicator_data_pivot
AS
 with indicator_join as (
  select
    geometry_id, hazard_value, id.absolute_value, id.normalized_value, range, i.slug, i.name as indicator_name, c.name as category_name
  from
    indicator_data id
  inner join indicators i on
    id.indicator_id = i.id
  inner join categories c on
    i.category_id = c.id)
    select jsonb_object_agg(slug || '_hazard', hazard_value) || jsonb_object_agg(slug || '_abs', absolute_value) || jsonb_object_agg(slug || '_norm', normalized_value) || jsonb_object_agg(slug, indicator_name) || jsonb_object_agg(slug || '_cat', category_name) as properties, geometry_id
    from
      indicator_join
    group by
      geometry_id
WITH NO DATA;
REFRESH MATERIALIZED VIEW indicator_data_pivot;
      SQL
    ActiveRecord::Base.connection.execute query
  end
end
