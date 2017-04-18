RSpec.describe AccountStatus, type: :model do
  let(:fcrepo_endpoint) { double(ping: true) }
  let(:solr_endpoint) { double(ping: true) }
  let(:redis_endpoint) { double(ping: true) }
  let(:account) {
    double(
      fcrepo_endpoint: fcrepo_endpoint,
      solr_endpoint: solr_endpoint,
      redis_endpoint: redis_endpoint
    )
  }
  let(:status) { described_class.new(account)}

  describe '#services' do
    subject { status.services }

    context 'during happy times' do
      it 'returns statuses about the account' do
        expect(subject).to match a_hash_including(
          fedora: true,
          solr: true,
          redis: true,
          database: true
        )
      end
    end

    context 'during hard times' do
      let(:fcrepo_endpoint) { double(ping: false) }
      let(:redis_endpoint) { double(ping: false) }
      it 'returns statuses about the account' do
        expect(subject).to match a_hash_including(
          fedora: false,
          solr: true,
          redis: false,
          database: true
        )
      end
    end

    context 'during initialization' do
      let(:solr_endpoint) { nil }
      it 'returns statuses about the account' do
        expect{ subject }.not_to raise_exception
        expect(subject).to match a_hash_including(
          fedora: true,
          solr: false,
          redis: true,
          database: true
        )
      end
    end
  end
end
