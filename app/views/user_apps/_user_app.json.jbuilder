json.extract! user_app, :id, :user_id, :app_id, :created_at, :updated_at
json.url user_app_url(user_app, format: :json)
