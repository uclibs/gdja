# Generated via
#  `rails generate hyrax:work Publication`
module Hyrax
  class PublicationPresenter < Hyrax::WorkShowPresenter
    delegate :journal_title, :extent, :alternate_title, :frequency, :editor, :holding_institution, :date_range, :geographic_location, :geo_subject, :volume, :page, to: :solr_document
  end
end
