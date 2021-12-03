class Translation < ApplicationRecord
  include ValidateLanguageCode

  # association
  belongs_to :glossary, optional: true

  # validations
  validates :source_text, presence: true, length: { maximum: 5000 }
  validates :source_language_code, :target_language_code, presence: true
  validate :language_code, on: [:create, :update], unless: :glossary_id

  # callback
  before_save :match_language_codes, if: :glossary_id

  private

  def match_language_codes
    glossary = Glossary.find_by_id(glossary_id)

    return false unless glossary.present?

    source_match = glossary.source_language_code == source_language_code
    target_match = glossary.target_language_code == target_language_code

    errors.add(:message, 'language codes must match with glossary language codes') unless source_match && target_match
  end
end
