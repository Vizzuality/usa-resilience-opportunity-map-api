class BulkInsertService
  def initialize(model, bulk_size = 1_000)
    @model = model
    @bulk_size = bulk_size
    @threads = {}
    @elements = []
    @index = 1
  end

  # Inserts an element in the @elements array.
  # If the number of elements exceeds the bulk_size it inserts the @elements in the database
  # @param element Hash
  def call(element)
    set_time(element)
    @elements << element

    insert_elements if @elements.count >= @bulk_size
  end

  def terminate
    insert_elements
    @threads.values.each(&:join)
    puts 'Terminated all threads'
  end

  private

  # Sets the created_at and updated_at attributes
  def set_time(element)
    time = Time.now
    element[:created_at] ||= time
    element[:updated_at] ||= time
  end

  # Bulk inserts the @elements
  def insert_elements
    current_elements = @elements
    @elements = []

    while @threads.count > 3
      sleep 0.1
    end

    Thread.new do
      @threads[Thread.current.object_id] = Thread.current
      @model.insert_all(current_elements)
      puts "Inserted the #{ActiveSupport::Inflector::ordinalize(@index)} #{current_elements.count} #{@model.to_s.pluralize}"
      @index += 1
      @threads.delete Thread.current.object_id
    rescue Exception
      puts "Crashed #{Thread.current.object_id}"
    end
  end

end
