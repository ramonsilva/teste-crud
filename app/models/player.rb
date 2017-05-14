class Player
  include Mongoid::Document
  field :name, type: String
  field :number, type: String
  field :position, type: String
end
