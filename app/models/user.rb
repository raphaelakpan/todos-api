class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # model associations
  has_many :todos, foreign_key: :created_by, dependent: :destroy

  # model validations
  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
