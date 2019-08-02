json.extract! user_info, :id, :created_at, :updated_at
json.url user_info_url(user_info, format: :json)
