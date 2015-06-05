module Spine
  module Restrictions
    class Collection
      attr_reader :registrations

      def initialize
        @registrations = []
      end

      def register(restriction)
        registration = Registration.new(restriction)
        registrations.unshift(registration)
        registration
      end

      def restricted?(context, action, resource)
        restrictions(action, resource).detect { |restriction|
          restriction.restricted?(context)
        }
      end

      def configure(&block)
        instance_eval &block
      end

      def restrictions(action, resource)
        registrations.select { |registration|
          registration.applies?(action, resource)
        }.map { |registration|
          registration.restriction
        }
      end
    end
  end
end
