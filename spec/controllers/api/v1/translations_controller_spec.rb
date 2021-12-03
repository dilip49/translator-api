require 'rails_helper'

describe Api::V1::TranslationsController, type: :controller do
  before do
    # language codes creation
    FactoryBot.create(:language_code)
    FactoryBot.create(:language_code, code: 'ab', country: 'Abkhazian')

    FactoryBot.create(:glossary, source_language_code: 'aa', target_language_code: 'ab')
    Glossary.first.terms.create(source_term: 'sky blue', target_term: 'azure')
  end

  describe '#create' do
    context 'on success' do
      before do
        post :create, params: { source_language_code: 'aa',
                                target_language_code: 'ab',
                                source_text: 'This is a sky blue color.',
                                glossary_id: Glossary.first.id }
      end

      it 'should created translation' do
        parsed_data = JSON.parse(response.body)['data']
        expect(Translation.count).to eq(1)
        expect(parsed_data['id']).to eq(1)
      end
    end

    context 'on failure' do
      before do
        post :create, params: { source_language_code: 'aa', target_language_code: 'ab' }
      end

      it 'should error messages' do
        message = JSON.parse(response.body)['responseMessage'].first
        expect(message).to match("Source text can't be blank")
      end
    end
  end

  describe '#show' do
    context 'when glossary id is present' do
      before do
        Translation.create(source_language_code: 'aa',
                           target_language_code: 'ab',
                           source_text: 'This is a sky blue color.',
                           glossary_id: Glossary.first.id)
        get :show, params: { id: 1 }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return source text with highlighted terms ' do
        source_text = JSON.parse(response.body)['data']['source_text']
        expect(source_text).to match('This is a <HIGHLIGHT>sky blue</HIGHLIGHT> color.')
      end
    end

    context 'when glossary_id is not present' do
      before do
        Translation.create(source_language_code: 'aa',
                           target_language_code: 'ab',
                           source_text: 'This is a sky blue color.')
        get :show, params: { id: 1 }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return translation' do
        source_text = JSON.parse(response.body)['data']['source_text']
        expect(source_text).to match('This is a sky blue color.')
      end
    end

    context 'when translation is not present' do
      before do
        get :show, params: { id: 100 }
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return not found error' do
        message = JSON.parse(response.body)['responseMessage']
        expect(message).to match('record not found')
      end
    end
  end
end
