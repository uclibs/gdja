# Generated via
#  `rails generate hyrax:work Journal`
module Hyrax
  class JournalPresenter < Hyrax::WorkShowPresenter
    delegate :extent, :alternate_title, :frequency, :editor, :holding_institution, :geographic_location, :geo_subject, to: :solr_document
  end
end
