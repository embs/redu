module ActiveRecord
  class Observer
    def self.with_observers(observer)
      ActiveRecord::Base.observers.enable observer
      observer.to_s.camelize.constantize.instance.send(:initialize)

      yield

      ActiveRecord::Base.observers.disable observer
    end
  end
end
