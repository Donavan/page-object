module PageObject
  module Elements
    class UnorderedList < Element
      include Enumerable

      #
      # iterator that yields with a PageObject::Elements::ListItem
      #
      # @return [PageObject::Elements::ListItem]
      #
      def each(&block)
        list_items.each(&block)
      end

      #
      # Return the PageObject::Elements::ListItem for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::ListItem]
      #
      def [](idx)
        list_items[idx]
      end

      #
      # Return the number of items contained in the unordered list
      #
      def items
        list_items.size
      end

      #
      # Return Array of ListItem objects that are children of the UnorderedList
      #
      def list_items
        @list_items ||= children(tag_name: 'li').map do |obj|
          Object::PageObject::Elements::ListItem.new(obj)
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:ul] = ::PageObject::Elements::UnorderedList
  end
end
