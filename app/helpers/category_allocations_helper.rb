module CategoryAllocationsHelper
  def allocation_collection_url_for(transaction)
    key = transaction.class.name.downcase 
    "/#{key.pluralize}/#{transaction.id}/category_allocations"
  end
end
