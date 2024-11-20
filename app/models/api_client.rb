class ApiClient < ApplicationRecord
  encrypts :api_key

  validates :name, presence: true
  validates :api_key, presence: true, uniqueness: true

  def self.valid_key?(key)
    exists?(api_key: key)
  end
end
