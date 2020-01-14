class Product < ApplicationRecord
    belongs_to :user
    searchkick word_start: [:pname, :pdescription]
    has_many_attached :images

    def search_data
      {
        pname: pname,
        pdescription: pdescription
      }
    end

    
      
end
