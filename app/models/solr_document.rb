# frozen_string_literal: true

class SolrDocument
  include Blacklight::Solr::Document
  include BlacklightOaiProvider::SolrDocument

  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior

  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.
  use_extension(Hydra::ContentNegotiation)

  attribute :extent, Solr::Array, solr_name('extent')
  attribute :rendering_ids, Solr::Array, solr_name('hasFormat', :symbol)

  field_semantics.merge!(
    contributor: 'contributor_tesim',
    creator: 'creator_tesim',
    date: 'date_created_tesim',
    description: 'description_tesim',
    identifier: 'identifier_tesim',
    language: 'language_tesim',
    publisher: 'publisher_tesim',
    relation: 'nesting_collection__pathnames_ssim',
    rights: 'rights_statement_tesim',
    subject: 'subject_tesim',
    title: 'title_tesim',
    type: 'human_readable_type_tesim'
  )

  # Added fields for all worktypes

  def alternate_title
    self[Solrizer.solr_name('alternate_title')]
  end

  def frequency
    self[Solrizer.solr_name('frequency')]
  end

  def editor
    self[Solrizer.solr_name('editor')]
  end

  def holding_institution
    self[Solrizer.solr_name('holding_institution')]
  end

  def geographic_location
    self[Solrizer.solr_name('geographic_location')]
  end

  def geo_subject
    self[Solrizer.solr_name('geo_subject')]
  end

  def date_range
    self[Solrizer.solr_name('date_range')]
  end

  def journal_title
    self[Solrizer.solr_name('journal_title')]
  end

  def volume
    self[Solrizer.solr_name('volume')]
  end

  def page
    self[Solrizer.solr_name('page')]
  end

  def pub_format
    self[Solrizer.solr_name('pub_format')]
  end
end
