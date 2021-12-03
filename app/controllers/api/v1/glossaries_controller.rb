class Api::V1::GlossariesController < ApplicationController
  def index
    glossaries = Glossary.all
    render json: glossaries.page(params[:page]).per(params[:per_page]).as_json(include: :terms)
  end

  def create
    glossary = Glossary.new(glossary_params)

    return render_success_response('created', glossary) if glossary.save

    render_error_response(glossary.errors.full_messages.to_sentence)
  end

  def show
    glossary = Glossary.find_by_id(params[:id])

    return render_success_response('record found', glossary.as_json(include: :terms)) if glossary.present?

    render_not_found_response('record not found')
  end

  private

  def glossary_params
    params.permit(:target_language_code, :source_language_code)
  end
end
