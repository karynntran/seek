json.array!(@users) do |user|
  json.extract! user, :id, :username, :password_hash, :avatar, :favorites
  json.url user_url(user, format: :json)
end
