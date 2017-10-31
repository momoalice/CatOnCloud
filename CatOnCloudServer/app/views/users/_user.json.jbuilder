json.extract! user, :id, :name, :intro, :subscribed, :created_at, :updated_at
json.url user_url(user, format: :json)
