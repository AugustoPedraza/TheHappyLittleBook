# encoding: UTF-8

class Book < ActiveRecord::Base
  default_scope order('published_at')

  has_and_belongs_to_many :authors

  attr_accessible :description, :edition, :isbn13, :published_at, :title

  validates :description,      presence: true
  validates :edition,          presence: true
  validates :isbn13,           presence: true, :uniqueness => true
  validates :published_at,     presence: true
  validates :title,            presence: true,
    uniqueness: { scope: :edition,
      message: "No puede haber un libro con el mismo título e número de edición."}

  def summary
    description[0..140] + "..."
  end

  def full_name
    title + " (#{edition}° edición)"
  end
end
