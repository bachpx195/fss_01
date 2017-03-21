class CalculateViewsCountService
  def initialize object
    @object = object
  end

  def calculate
    @object.increment! :views_count
  end
end
