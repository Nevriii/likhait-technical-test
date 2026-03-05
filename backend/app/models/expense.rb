class Expense < ApplicationRecord
  belongs_to :category
  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true
  #--- My Edit ---
  validate :date_cannot_be_in_the_future
  def date_cannot_be_in_the_future
    if date.present? && date > Time.today
      errors.add(:date, "cannot be in the future")
    end
  end

end
