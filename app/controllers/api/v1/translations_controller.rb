class Api::V1::TranslationsController < ApplicationController
  def create
    translation = Translation.new(translation_params)

    return render_success_response('created', translation) if translation.save

    render_error_response(translation.errors.full_messages)
  end

  def show
    translation = Translation.find_by_id(params[:id])

    return render_success_response('record found', translation_with_terms(translation)) if translation.present?

    render_not_found_response('record not found')
  end

  private

  def translation_params
    params.permit(:source_language_code, :target_language_code, :source_text, :glossary_id)
  end

  def translation_with_terms(translation)
    translation.glossary_id? ? highlight_source_terms(translation) : translation
  end

  def highlight_source_terms(translation)
    source_text = translation.source_text
    translation
      .glossary
      .terms
      .each do |term|
        source_text = source_text.gsub(term.source_term, "<HIGHLIGHT>#{term.source_term}</HIGHLIGHT>")
      end

    translation.source_text = source_text
    translation
  end
end
