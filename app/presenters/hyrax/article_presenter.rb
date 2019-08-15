# Generated via
#  `rails generate hyrax:work Article`
module Hyrax
  class ArticlePresenter < Hyrax::WorkShowPresenter
    delegate :journal_title, :holding_institution, :date_range, :geographic_location, :geo_subject, :volume, :page, to: :solr_document
  end
end
