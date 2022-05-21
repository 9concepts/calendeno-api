class User < ApplicationRecord
  GOOGLE_ISSUERS = ['accounts.google.com', 'https://accounts.google.com'].freeze

  validates :email, presence: true, uniqueness: true
  validates :image, presence: true
  validates :iss, presence: true, inclusion: {in: GOOGLE_ISSUERS}
  validates :sub, presence: true

  validate :sub_should_be_unique_in_same_issuers

  def sub_should_be_unique_in_same_issuers
    if GOOGLE_ISSUERS.include?(iss) && User.where(iss: GOOGLE_ISSUERS, sub:).exists?
      errors.add(:sub, 'should be unique in the same issuers')
    end
  end
end
