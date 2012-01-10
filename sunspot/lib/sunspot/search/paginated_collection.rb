module Sunspot
  module Search

    class PaginatedCollection
      (instance_methods-%w[instance_eval object_id respond_to? class inspect]).each { |m|
        undef_method m unless m =~ /^__|instance_eval|object_id/
      }

      def initialize(collection, page, per_page, total)
        @collection   = collection
        @current_page = page
        @per_page     = per_page
        @total_count  = total
      end


      def respond_to?(*args)
        super || @collection.respond_to?(*args)
      end

      private

      def method_missing(method, *args, &block)
        @collection.send(method, *args, &block)
      end
    end

  end
end
