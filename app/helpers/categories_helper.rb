module CategoriesHelper
  def category_selection
    nested_set_options(Category, @category){ |i| "#{'..' * i.level} #{i.name}" }
  end
end
