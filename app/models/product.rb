class Product < ApplicationRecord
    belongs_to :user

    has_many_attached :images

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
