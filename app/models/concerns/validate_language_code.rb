module ValidateLanguageCode
  extend ActiveSupport::Concern

  def language_code
    errors.add(:source_language_code, 'should be valid') unless LanguageCode.find_by_code(source_language_code)
    errors.add(:target_language_code, 'should be valid') unless LanguageCode.find_by_code(target_language_code)
  end
end
