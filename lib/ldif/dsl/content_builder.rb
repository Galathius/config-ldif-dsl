require 'docile'
require_relative 'person'
require_relative 'group'

module LDIF
  module DSL
    class ContentBuilder
      def initialize
        @groups = []
        @people = []
      end

      def person(&block)
        @people.push(Docile.dsl_eval(Person::Builder.new, &block).build)
        self
      end

      def group(&block)
        @groups.push(Docile.dsl_eval(Group::Builder.new, &block).build)
        self
      end

      def build
        billet = "version: 1\n\n"
        billet << organizational_unit('people')
        billet << "\n"
        billet << organizational_unit('groups')
        billet << "\n" unless @groups.empty?
        billet << @groups.join("\n")
        billet << "\n" unless @people.empty?
        billet << @people.join("\n")
      end

    private
      attr_accessor :people, :groups

      def organizational_unit(name)
        <<-TEXT
dn: ou=#{name},dc=test
ou: #{name}
objectClass: top
objectclass: organizationalUnit
TEXT
      end
    end
  end
end