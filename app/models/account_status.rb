# Interrogation of statuses for an Account (and other aspects of the system)
class AccountStatus
  attr_reader :account

  # @param [Account] account
  def initialize(account)
    @account = account
  end

  # Not to_hash
  # @return [Hash{Symbol => Boolean}]
  def services
    {
      fedora: account.fcrepo_endpoint.nil? ? false : account.fcrepo_endpoint.ping,
      solr:   account.solr_endpoint.nil?   ? false : account.solr_endpoint.ping,
      redis:  account.redis_endpoint.nil?  ? false : account.redis_endpoint.ping,
      database: ActiveRecord::Base.connection.active?
    }
  end
end
