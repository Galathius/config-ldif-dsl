# Ldif

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'config-ldif-dsl' , github: 'Galathius/config-ldif-dsl'

And then execute:

    $ bundle


## Usage

    require 'ldif'

	block = 
      proc do
        person do
          first_name 'John'
          second_name 'Doe'
          password '123qwe'
        end

        group do
          name 'administrators'
          member 'John_Doe'
        end
      end
    
    LDIF::DSL.ldif(&block))

Result:

    version: 1

	dn: ou=people,dc=test
	ou: people
	objectClass: top
	objectclass: organizationalUnit

	dn: ou=groups,dc=test
	ou: groups
	objectClass: top
	objectclass: organizationalUnit

	dn: cn=administrators,ou=groups,dc=test
	objectclass: top
	objectClass: groupOfUniqueNames
	cn: administrators
	ou: groups
	uniqueMember: cn=John_Doe,ou=people,dc=test

	dn: cn=John_Doe,ou=people,dc=test
	cn: John_Doe
	sn: Doe
	givenName: John
	mail: John_Doe@example.com
	userpassword: {SHA}Bf50YcYHwzIpdy1AJQVgEBan0Oo=
	objectclass: top
	objectclass: person
	objectClass: organizationalPerson
	objectclass: inetOrgPerson

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
