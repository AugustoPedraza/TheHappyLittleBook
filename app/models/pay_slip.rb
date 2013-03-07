class PaySlip < ActiveRecord::Base
  has_many :pay_slip_items
  has_one  :basic_salary
  attr_accessible :date, :period

  validates :date, :period, presence: true

  # def total
  # end
end
