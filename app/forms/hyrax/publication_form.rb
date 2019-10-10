# Generated via
#  `rails generate hyrax:work Publication`
module Hyrax
  # Generated form for Publication
  class PublicationForm < Hyrax::Forms::WorkForm
    self.model_class = ::Publication

    self.terms += %i[alternate_title journal_title extent frequency editor date_range holding_institution geographic_location geo_subject volume page]
    ## remove fields
    self.terms -= %i[identifier resource_type based_near date_created creator contributor source keyword]

    ## Setting custom required fields
    self.required_fields = %i[title date_range description holding_institution geographic_location]

  def primary_terms
    %i[related_url title alternate_title extent frequency date_range description editor publisher holding_institution geographic_location subject geo_subject rights_statement license]
    end
  end
end
