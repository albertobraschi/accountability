module OutgoingCategoriesHelper
  def category_selection
    nested_set_options(OutgoingCategory, @outgoing_category){ |i| "#{'..' * i.level} #{i.name}" }
  end
end
