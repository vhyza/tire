# Example ActiveModel with validations

class ValidatedModel

  include Tire::Model::Persistence
  include Tire::Model::Persistence::Validations::Uniqueness

  property :name

  validates_presence_of :name
  validates_uniqueness_of :name

end
