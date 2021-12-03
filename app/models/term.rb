class Term < ApplicationRecord
  # association
  belongs_to :glossary

  # validation
  validates :source_term, :target_term, presence: true
end
