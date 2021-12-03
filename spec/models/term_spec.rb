require 'rails_helper'

describe Term do
  before do
    # language codes creation
    FactoryBot.create(:language_code)
    FactoryBot.create(:language_code, code: 'ab', country: 'Abkhazian')

    FactoryBot.create(:glossary, source_language_code: 'aa', target_language_code: 'aa')
  end

  it 'should be valid with attributes and create term' do
    term = Term.create(source_term: 'sky blue', target_term: 'azure', glossary_id: Glossary.first.id)
    expect(term).to be_valid
    expect(Term.count).to eq(1)
  end

  it 'should not valid without attributes' do
    term = Term.create(source_term: nil, target_term: nil, glossary_id: Glossary.first.id)
    expect(term).to_not be_valid
  end
end
