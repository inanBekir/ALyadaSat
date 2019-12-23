class Product < ApplicationRecord
    belongs_to :user

    has_attached_file :photo, styles: { medium: "1920x1080>", thumb: "100x100>" }, default_url: "deneme.jpeg"
    validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings do
        mappings dynamic: false do
          indexes :pname, type: :text
          indexes :pdescription, type: :text, analyzer: :english
        end
      end

      def self.search_isonsell(query)
        self.search({
          query: {
            bool: {
              must: [
              {
                multi_match: {
                  query: query,
                  fields: [:pname, :pdescription]
                }
              },
              {
                match: {
                  isonsell: true
                }
              }]
            }
          }
        })
      end
      
end
