module LDIF
  module DSL
    class Group < Struct.new(:name, :members)
      def to_s
        billet = <<-TEXT
dn: cn=#{name},ou=groups,dc=test
objectclass: top
objectClass: groupOfUniqueNames
cn: #{name}
ou: groups
TEXT
        billet << members.map { |m| "uniqueMember: cn=#{m},ou=people,dc=test" }.join("\n")
        billet << "\n" unless members.empty?
        billet
      end

      class Builder
        def initialize
          @members = []
        end

        def name(name)
          @name = name
          self
        end

        def member(username)
          @members.push(username)
          self
        end

        def build
          Group.new(@name, @members)
        end
      end
    end
  end
end