# -*- encoding : utf-8 -*-
shared_examples_for 'cache writing' do
  render_views

  before do
    @controller = controller
    @controller.stub(:current_user) { user }
  end

  xit 'writes a cache' do
    performing_cache do |cache|
      requisition

      cache.should exist(cache_identifier)
    end
  end
end
