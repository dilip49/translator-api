require 'rails_helper'

describe Api::V1::TermsController, type: :controller do
  before do
    # language codes creation
    FactoryBot.create(:language_code)
    FactoryBot.create(:language_code, code: 'ab', country: 'Abkhazian')

    FactoryBot.create(:glossary, source_language_code: 'aa', target_language_code: 'ab')
  end

  describe '#create' do
    context 'on success' do
      before do
        post :create, params: { source_term: 'insisted', target_term: 'urged', glossary_id: Glossary.first.id }
      end

      it 'should created term' do
        parsed_data = JSON.parse(response.body)['data']
        expect(parsed_data['id']).to eq(1)
      end
    end

    context 'on failure' do
      before do
        post :create, params: { source_term: 'insisted', glossary_id: Glossary.first.id }
      end

      it 'should return error messages' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['responseMessage']).to match(["Target term can't be blank"])
      end
    end
  end
end
