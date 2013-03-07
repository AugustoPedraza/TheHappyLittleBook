class PaySlipItem < ActiveRecord::Base
  has_one :salary_concept
  belongs_to :pay_slip

  attr_accessible :amount

  validates :amount, presence: true
  # def description
  # end

  # def subtotal
  # end
end
