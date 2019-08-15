# Generated via
#  `rails generate hyrax:work Article`
module Hyrax
  # Generated form for Article
  class ArticleForm < Hyrax::Forms::WorkForm
    self.model_class = ::Article
    self.terms += %i[journal_title date_range holding_institution geographic_location geo_subject volume page]
    ## remove fields
    self.terms -= %i[identifier resource_type based_near date_created contributor source keyword]

    ## Setting custom required fields
    self.required_fields = %i[title date_range publisher holding_institution geographic_location]

  def primary_terms
    %i[related_url title creator journal_title date_range description publisher volume page holding_institution geographic_location subject geo_subject rights_statement license]
    end

  end
end
