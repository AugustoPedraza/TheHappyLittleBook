class SalaryConcept < ActiveRecord::Base
  attr_accessible :cod, :deduction, :description, :effect_since, :effect_to, :gainful, :percent

  validates :description, :cod, :percent, :effect_since, presence: true
end
