class User < ApplicationRecord
  
  has_many :matches, foreign_key: :owner_id
  
  def games
    Match.where(result: nil).where(owner_id: id).or(Match.where(opponent_id: id))
  end
  
end