# -*- encoding : utf-8 -*-
require 'spec_helper'

module StatusService
  describe User do
    subject { FactoryGirl.create(:user) }
    let(:facade) { double("Facade") }

    describe "before_destroy" do
      it "should invoke User#destroy_statuses" do
        subject.should_receive(:destroy_statuses).with(no_args())
        subject.destroy
      end
    end

    describe "#destroy_statuses" do
      it "should invoke Facade#destroy_status with self" do
        mock_facade(facade)
        facade.should_receive(:destroy_status).with(subject)
        subject.send(:destroy_statuses)
      end
    end

    def mock_facade(m)
      allow(Facade).to receive(:instance).and_return(m)
    end
  end
end
