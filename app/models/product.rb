class Product < ApplicationRecord
    has_attached_file :photo, styles: { medium: "1920x1080>", thumb: "100x100>" }, default_url: "deneme.jpeg"
    validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
