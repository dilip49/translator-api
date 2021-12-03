require 'rails_helper'

describe Translation do
  before do
    # language codes creation
    FactoryBot.create(:language_code)
    FactoryBot.create(:language_code, code: 'ab', country: 'Abkhazian')
  end

  let(:translation) do
    FactoryBot.build(:translation,
                     source_language_code: 'aa',
                     target_language_code: 'ab',
                     source_text: 'This is test!')
  end

  it 'should be valid with attributes' do
    expect(translation).to be_valid
  end

  it 'should return error message if source language code is not present' do
    translation.source_language_code = nil
    translation.valid?
    expect(translation.errors.full_messages.first).to eq("Source language code can't be blank")
  end

  it 'should return error message if target language code is not present' do
    translation.target_language_code = nil
    translation.valid?
    expect(translation.errors.full_messages.first).to eq("Target language code can't be blank")
  end

  it 'should not be valid if source text is not present' do
    translation.source_text = nil
    expect(translation).to_not be_valid
    expect(translation.errors.full_messages.first).to eq("Source text can't be blank")
  end

  it 'should not be valid if source language code, target language code and source text is not present' do
    translation.source_language_code = nil
    translation.target_language_code = nil
    translation.source_text = nil
    expect(translation).to_not be_valid
    expect(translation.errors.full_messages.second).to eq("Source language code can't be blank")
    expect(translation.errors.full_messages.first).to eq("Source text can't be blank")
    expect(translation.errors.full_messages.third).to eq("Target language code can't be blank")
  end

  it 'it should not be valid if source text has more than 5000 characters' do
    translation.source_text = 'TestString' * 5000
    expect(translation).to_not be_valid
    expect(translation.errors.full_messages.first).to eq('Source text is too long (maximum is 5000 characters)')
  end
end
