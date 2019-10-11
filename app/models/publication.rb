# Generated via
#  `rails generate hyrax:work Publication`
class Publication < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = PublicationIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :pub_format, predicate: ::RDF::URI.new('http://purl.org/dc/terms/format'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :alternate_title, predicate: ::RDF::URI.new('http://purl.org/dc/terms/title#alternative') do |index|
    index.as :stored_searchable
  end

  property :journal_title, predicate: ::RDF::URI.new('http://purl.org/dc/terms/isPartOf#title') do |index|
    index.as :stored_searchable
  end

  property :frequency, predicate: ::RDF::URI.new('http://purl.org/dc/terms/description#frequncy'), multiple: true do |index|
    index.as :stored_searchable
  end

  property :extent, predicate: ::RDF::URI.new('http://purl.org/dc/terms/extent') do |index|
    index.as :stored_searchable
  end

  property :editor, predicate: ::RDF::URI.new('http://purl.org/dc/terms/contributor') do |index|
    index.as :stored_searchable
  end

  property :holding_institution, predicate: ::RDF::URI.new('http://purl.org/dc/terms/provenance#holdingInstitution'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :geographic_location, predicate: ::RDF::URI.new('http://purl.org/dc/terms/spatial'), multiple: true do |index|
    index.as :stored_searchable
  end

  property :geo_subject, predicate: ::RDF::URI.new('http://purl.org/dc/terms/coverage#spatial') do |index|
    index.as :stored_searchable
  end

  property :date_range, predicate: ::RDF::URI.new('http://purl.org/dc/terms/created') do |index|
    index.as :stored_searchable, :facetable
  end

  property :volume, predicate: ::RDF::URI.new('http://purl.org/dc/terms/identifier#volume') do |index|
    index.as :stored_searchable, :facetable
  end

  property :page, predicate: ::RDF::URI.new('http://purl.org/dc/terms/identifier#page') do |index|
    index.as :stored_searchable, :facetable
  end



  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
