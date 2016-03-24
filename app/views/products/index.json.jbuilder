json.array!(@products) do |product|
  json.extract! product, :id, :name, :mfg, :description, :url, :image, :user_id
  json.url product_url(product, format: :json)
end
