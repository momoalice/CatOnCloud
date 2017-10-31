json.extract! user_auth, :id, :name, :password, :user_id, :created_at, :updated_at
json.url user_auth_url(user_auth, format: :json)
