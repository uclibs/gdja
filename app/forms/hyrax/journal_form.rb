# Generated via
#  `rails generate hyrax:work Journal`
module Hyrax
  # Generated form for Journal
  class JournalForm < Hyrax::Forms::WorkForm
    self.model_class = ::Journal
    self.terms += %i[alternate_title extent frequency editor holding_institution geographic_location geo_subject]
    ## remove fields
    self.terms -= %i[identifier resource_type based_near creator contributor source keyword]

    ## Setting custom required fields
    self.required_fields = %i[title extent date_created description editor publisher holding_institution geographic_location]

  def primary_terms
    %i[related_url title alternate_title extent frequency date_created description editor publisher holding_institution geographic_location subject geo_subject rights_statement license]
    end

  end
end
