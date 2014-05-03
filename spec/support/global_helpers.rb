module DevYoung
  module GlobalHelpers
    def self.included(base)
      base.let(:user1) { create(:user) }
      base.let(:user2) { create(:user2) }
      base.let(:user3) { create(:user3) }

      base.let(:group_attrs) { FactoryGirl.attributes_for(:group) }
      base.let(:group1) { user1.create_group(group_attrs) }
      # base.let(:group2) { create(:group) }
    end
  end  
end