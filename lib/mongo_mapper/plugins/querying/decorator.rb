# encoding: UTF-8
module MongoMapper
  module Plugins
    module Querying
      module Decorator
        def model(model=nil)
          return @model if model.nil?
          @model = model
          self
        end

        def find!(*ids)
          raise DocumentNotFound, "Couldn't find without an ID" if ids.size == 0

          find(*ids).tap do |result|
            if result.nil? || ids.size != Array(result).size
              raise DocumentNotFound, "Couldn't find all of the ids (#{ids.join(',')}). Found #{Array(result).size}, but was expecting #{ids.size}"
            end
          end
        end

        def all(opts={})
          super.map { |doc| model.load(doc) }
        end

        def first(opts={})
          model.load(super)
        end

        def last(opts={})
          model.load(super)
        end
      end
    end
  end
end