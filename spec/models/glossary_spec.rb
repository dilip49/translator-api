require 'rails_helper'

describe Glossary do
  before do
    # language codes creation
    FactoryBot.create(:language_code)
    FactoryBot.create(:language_code, code: 'ab', country: 'Abkhazian')
  end

  let!(:glossary) { FactoryBot.create(:glossary, source_language_code: 'aa', target_language_code: 'ab') }

  it 'is valid with valid attributes' do
    expect(glossary).to be_valid
  end

  it 'is not valid without a source language_code' do
    glossary.source_language_code = nil
    expect(glossary).to_not be_valid
  end

  it 'is not valid without a target language code' do
    glossary.target_language_code = nil
    expect(glossary).to_not be_valid
  end

  it 'is not valid without source language code and target language code' do
    glossary.target_language_code = nil
    glossary.source_language_code = nil
    expect(glossary).to_not be_valid
  end

  it 'is valid if language codes have valid ISO 639-1 code' do
    expect(glossary).to be_valid
    expect(LanguageCode.find_by(code: glossary.target_language_code)).to eq(LanguageCode.last)
    expect(LanguageCode.find_by(code: glossary.source_language_code)).to eq(LanguageCode.first)
  end

  it 'is not valid if language codes does not have valid ISO 639-1 code' do
    glossary = Glossary.new(source_language_code: 'pk', target_language_code: 'ct')
    expect(glossary).to_not be_valid
  end

  it 'should validate format for source language code field' do
    glossary.source_language_code = 'aaaa'
    glossary.valid?
    expect(glossary.errors.full_messages.first).to eq('Source language code should be valid')
  end

  it 'should validate format for target language_code' do
    glossary.target_language_code = 'aaaa'
    glossary.valid?
    expect(glossary.errors.full_messages.first).to eq('Target language code should be valid')
  end

  context 'when glossaries are unique' do
    FactoryBot.build(:glossary, source_language_code: 'aa', target_language_code: 'ab')
    let!(:glossary) { FactoryBot.create(:glossary, source_language_code: 'ab', target_language_code: 'aa') }

    it 'should be valid' do
      expect(glossary).to be_valid
    end
  end

  context 'when glossaries are not unique' do
    before do
      FactoryBot.create(:glossary, source_language_code: 'ab', target_language_code: 'aa')
    end

    it 'should return error message' do
      glossary = Glossary.new(source_language_code: 'aa', target_language_code: 'ab')
      glossary.valid?
      expect(glossary.errors.full_messages.first).to eq('Source language code has already been taken')
    end
  end
end
