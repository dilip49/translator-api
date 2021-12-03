require 'rails_helper'

describe Api::V1::GlossariesController, type: :controller do
  before do
    # language codes creation
    FactoryBot.create(:language_code)
    FactoryBot.create(:language_code, code: 'ab', country: 'Abkhazian')
    FactoryBot.create(:language_code, code: 'ae', country: 'Avestan')
    FactoryBot.create(:language_code, code: 'af', country: 'Afrikaans')

    FactoryBot.create(:glossary, source_language_code: 'aa', target_language_code: 'ab')
    FactoryBot.create(:glossary, source_language_code: 'ae', target_language_code: 'af')
    get :index
  end

  describe '#index' do
    it 'should return all glossaries' do
      expect(JSON.parse(response.body).count).to eq(2)
    end
  end

  describe '#create' do
    valid_attributes = { target_language_code: 'aa', source_language_code: 'af' }
    context 'on success' do
      it 'should create glossary' do
        post :create, params: valid_attributes
        expect(Glossary.count).to eq(3)
      end
    end

    context 'on failure' do
      it 'should return error' do
        post :create, params: { target_language_code: 'aa' }
        error_message = JSON.parse(response.body)['responseMessage'].split(',').first
        expect(error_message).to match("Source language code can't be blank")
      end

      it 'should return error' do
        post :create, params: { source_language_code: 'aa' }
        error_message = JSON.parse(response.body)['responseMessage'].split(',').first
        expect(error_message).to match("Target language code can't be blank")
      end
    end
  end

  describe '#show' do
    context 'when glossary is present' do
      before do
        Glossary.first.terms.create(source_term: 'insisted', target_term: 'urged')
        get :show, params: { id: 1 }
      end

      it 'should return glossary with its terms' do
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['id']).to eq(1)
        expect(parsed_response['terms'].count).to eq(1)
        expect(parsed_response['terms'][0]['source_term']).to eq('insisted')
      end
    end

    context 'when glossary is not present' do
      before do
        get :show, params: { id: 100 }
      end

      it 'should return not found error' do
        message = JSON.parse(response.body)['responseMessage']
        expect(message).to match('record not found')
      end
    end
  end
end
