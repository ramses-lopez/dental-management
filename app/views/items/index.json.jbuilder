json.array!(@items) do |item|
  json.extract! item, :label, :stock
  json.url item_url(item, format: :json)
end