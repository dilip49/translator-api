class Api::V1::TermsController < ApplicationController
  def create
    glossary = Glossary.find_by_id(params[:glossary_id])
    term = glossary&.terms&.build(term_params)

    return render_success_response('created', term) if glossary.present? && term.save

    render_error_response(term.errors.full_messages)
  end

  private

  def term_params
    params.permit(:source_term, :target_term)
  end
end
