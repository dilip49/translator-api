require 'csv'

class Glossary < ApplicationRecord
  include ValidateLanguageCode

  # associations
  has_many :terms
  has_many :translations

  # validations
  validates :source_language_code, :target_language_code, presence: true, format: { with: /[a-z]{2}/ }
  validates :source_language_code, uniqueness: { scope: :target_language_code }
  validate :language_code, on: [:create, :update]
end
