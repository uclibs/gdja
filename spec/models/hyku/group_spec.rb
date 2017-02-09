require 'rails_helper'

# Hyku::Group attributes
module Hyku
  RSpec.describe Group do
    describe 'no members' do
      subject do
        described_class.new(
          name: name,
          description: description,
          key: key
        )
      end
      let(:name) { 'Empty Group' }
      let(:description) { 'Add members plz' }
      let(:key) { 'empty-group' }
      let(:empty_group_attributes) do
        {
          name: name,
          description: description,
          key: key,
          number_of_users: 0
        }
      end
      it { is_expected.to have_attributes(empty_group_attributes) }
      it { is_expected.to respond_to(:created_at) }
    end

    context '#key' do
      let(:example_name) { 'Group that tests key values' }
      let(:example_key) { described_class.format_key(example_name) }
      let(:existing_group) do
        FactoryGirl.create(
          :group,
          name: example_name,
          key: example_key
        )
      end

      context 'new group' do
        context 'provided key' do
          it 'must be unique' do
            expect { FactoryGirl.create(:group, key: existing_group.key) }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'generated key' do
          let(:attributes_with_implied_duplicate_key) do
            FactoryGirl.attributes_for(:group).merge(name: existing_group.name, key: nil)
          end

          it 'must be unique' do
            expect { described_class.new(attributes_with_implied_duplicate_key).save }.not_to raise_error
          end

          context 'will be used if one is not provided' do
            subject do
              group = described_class.new(FactoryGirl.attributes_for(:group).merge(key: nil))
              group.save
              group.key
            end

            it { is_expected.to be_truthy }
          end
        end
      end

      context 'prevents changing persisted value' do
        subject do
          existing_group.key = 'different-key'
          existing_group.save
          existing_group.errors
        end

        it { is_expected.to have_key(:key) }
      end
    end
  end
end

# Hyku::Group methods
module Hyku
  RSpec.describe Group do
    context '.search' do
      before(:context) do
        FactoryGirl.create(:group, name: 'IMPORTANT-GROUP-NAME')
        FactoryGirl.create(:group, description: 'IMPORTANT-GROUP-DESCRIPTION')
      end

      after(:context) do
        described_class.all.each(&:destroy)
      end

      it 'returns groups that match a query on a name' do
        expect(described_class.search('IMPORTANT-GROUP-NAME').count).to eq(1)
      end

      it 'returns groups that match a query on a description' do
        expect(described_class.search('IMPORTANT-GROUP-DESCRIPTION').count).to eq(1)
      end

      it 'returns groups with a partial match' do
        expect(described_class.search('IMPORTANT-GROUP').count).to eq(2)
      end

      it 'returns an empty set when there is no match' do
        expect(described_class.search('NULL').count).to eq(0)
      end
    end

    context '#search_members' do
      subject { FactoryGirl.create(:group) }
      let(:known_user_name) { FactoryGirl.create(:user, display_name: 'Tom Cramer') }
      let(:known_user_email) { FactoryGirl.create(:user, email: 'tom@project-hydra.com') }

      before { subject.add_members_by_id([known_user_name.id, known_user_email.id]) }

      it 'returns members based on name' do
        expect(subject.search_members(known_user_name.name).count).to eq(1)
      end

      it 'returns members based on email' do
        expect(subject.search_members(known_user_email.email).count).to eq(1)
      end

      it 'returns members based on partial matches' do
        expect(subject.search_members('Tom').count).to eq(1)
      end

      it 'returns an empty set when there is no match' do
        expect(subject.search_members('Jerry').count).to eq(0)
      end
    end

    describe '#add_members_by_id' do
      subject { FactoryGirl.create(:group) }
      let(:user) { FactoryGirl.create(:user) }
      before { subject.add_members_by_id(user.id) }

      it 'adds one user when passed a single user id' do
        expect(subject.members).to include(user)
      end

      # This is tested in the setup of #search_members and #remove_members_by_id
      it 'adds multiple users when passed a collection of user ids' do
      end
    end

    describe '#remove_members_by_id' do
      subject { FactoryGirl.create(:group) }

      context 'single user id' do
        let(:user) { FactoryGirl.create(:user) }
        before { subject.add_members_by_id(user.id) }

        it 'removes one user' do
          expect(subject.members).to include(user)
          subject.remove_members_by_id(user.id)
          expect(subject.members).not_to include(user)
        end
      end

      context 'collection of user ids' do
        let(:user_list) { FactoryGirl.create_list(:user, 3) }
        let(:user_ids) { user_list.collect(&:id) }
        before { subject.add_members_by_id(user_ids) }

        it 'removes multiple users' do
          expect(subject.members.collect(&:id)).to eq(user_ids)
          subject.remove_members_by_id(user_ids)
          expect(subject.members.count).to eq(0)
        end
      end
    end

    context '#number_of_users' do
      subject { FactoryGirl.create(:group) }
      let(:user) { FactoryGirl.create(:user) }

      it 'starts out with 0 users' do
        expect(subject.number_of_users).to eq(0)
      end

      it 'increments when users are added' do
        subject.add_members_by_id(user.id)
        expect(subject.number_of_users).to eq(1)
      end
    end
  end
end
