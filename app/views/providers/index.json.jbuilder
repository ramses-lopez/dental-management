json.array!(@providers) do |provider|
  json.extract! provider, 
  json.url provider_url(provider, format: :json)
end