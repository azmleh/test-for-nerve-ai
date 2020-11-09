class Match < ApplicationRecord
  
  belongs_to :owner, class_name: "User"
  belongs_to :opponent, class_name: "User", optional: true
  
end