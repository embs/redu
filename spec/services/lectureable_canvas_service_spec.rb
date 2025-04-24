require 'spec_helper'

describe LectureableCanvasService do
  let(:client) { FactoryGirl.create(:client_application) }
  let(:lecture) { FactoryGirl.build_stubbed(:lecture) }
  let(:ability) { mock('Ability') }
  let(:access_token) do
    t = mock('AccessToken')
    t.stub(:user).and_return(lecture.owner)
    t.stub(:client_application_id).and_return(client.id)
    t
  end
  let(:canvas_attrs) { FactoryGirl.attributes_for(:canvas) }

  subject do
    LectureableCanvasService.
      new(ability, canvas_attrs.merge(:access_token => access_token))
  end

  context "#create" do
    let(:canvas) { subject.create(lecture) }
    xit "should return a saved Canvas" do
      canvas.should be_a Api::Canvas
      canvas.should be_persisted
    end

    xit "should set the container to the lecture" do
      canvas.container.should == lecture
    end
  end
end
