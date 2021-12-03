FactoryBot.define do
  factory :term do
    glossary
    source_term { 'aa' }
    target_term { 'ae' }
  end
end
