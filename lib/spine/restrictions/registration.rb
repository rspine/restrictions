module Spine
  module Restrictions
    class Registration
      attr_reader :restriction, :restrictions, :exceptions

      def initialize(restriction)
        @restriction = restriction
        @exceptions = {}
        @restrictions = {}
      end

      def restrict(action, resource)
        add(restrictions, action, resource)
        self
      end

      def except(action, resource)
        add(exceptions, action, resource)
        self
      end

      def applies?(action, resource)
        return false if exception?(action, resource)

        includes?(restrictions, action, resource)
      end

      private

      def exception?(action, resource)
        includes?(exceptions, action, resource)
      end

      def includes?(collection, action, resource)
        actions = collection[resource] || collection[:all]
        return false unless actions

        actions[action] || actions[:all]
      end

      def add(collection, action, resource)
        collection[resource] ||= {}
        collection[resource][action] = true
      end
    end
  end
end
