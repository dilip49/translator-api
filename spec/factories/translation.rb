FactoryBot.define do
  factory :translation do
    glossary
    source_language_code { 'aa' }
    target_language_code { 'ae' }
    source_text { 'This is a test!' }
  end
end
