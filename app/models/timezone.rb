class Timezone < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: { uniquenes: true }
  validates :gmt_difference, presence: true, numericality: { greater_than_or_equal_to: 0 }
                    
end
