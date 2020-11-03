class BulkInsertService
  def initialize(model, bulk_size = 1_000)
    @model = model
    @bulk_size = bulk_size
    @elements = []
    @index = 1
  end

  def call(element, force = false)
    set_time(element)
    @elements << element
    if @elements.count >= @bulk_size || force
      @model.insert_all(@elements)
      Rails.logger.debug "Inserted the #{ActiveSupport::Inflector::ordinalize(@index)} #{element.count} #{@model.to_s.pluralize}"
      @index += 1
      @elements = []
    end
  end

  private

  def set_time(element)
    time = Time.now
    element[:created_at] ||= time
    element[:updated_at] ||= time
  end
end
