json.extract! product, :id, :pname, :pdescription, :pprice, :created_at, :updated_at
json.url product_url(product, format: :json)
