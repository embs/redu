# -*- encoding : utf-8 -*-
require 'spec_helper'

module StatusService
  module StatusableAdditions
    describe ModelAdditions do
      class ::Dummy
        include BaseModelAdditions
        include ModelAdditions
      end
      class StatusService::DummyHierarchyAggregator < Struct.new(:dummy) ; end

      subject { ::Dummy.new }
      let(:facade) { double("Facade") }

      describe "#activities" do
        it "should invoke Facade#activities with aggregator and relation" do
          mock_facade(facade)

          expect(facade).to receive(:activities) do |aggregator_arg, relation_arg|
            expect(aggregator_arg).to be_a(DummyHierarchyAggregator)
            expect(aggregator_arg.dummy).to eq subject
            expect(relation_arg).to be_an(ActiveRecord::Relation)
          end

          subject.activities
        end
      end

      def mock_facade(m)
        allow(Facade).to receive(:instance).and_return(m)
      end
    end
  end
end
