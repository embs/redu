# -*- encoding : utf-8 -*-
class BaseMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper
  extend  ActionView::Helpers::SanitizeHelper::ClassMethods # Required for rails 2.2

  include BaseHelper

  def self.delay(*args)
    self # noop
  end

  default :from => "\"Equipe Redu\" <#{Redu::Application.config.email}>",
      :content_type => "text/plain",
      :reply_to => "#{Redu::Application.config.email}"
end
