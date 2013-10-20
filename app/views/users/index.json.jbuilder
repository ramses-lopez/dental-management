json.array!(@users) do |user|
  json.extract! user, :name, :password, :username
  json.url user_url(user, format: :json)
end