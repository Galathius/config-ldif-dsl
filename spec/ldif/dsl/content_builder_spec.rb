require 'ldif/dsl/content_builder'
require 'ldif/dsl/person'
require 'ldif/dsl/group'
require 'pathname'
require 'docile'

module LDIF
  module DSL
    describe ContentBuilder do
      let(:content_builder) { ContentBuilder.new }
      subject { content_builder }

      describe '#person' do
        let(:name) { 'John' }
        before { content_builder.person { first_name name } }
        its(:people) { should include(Person.new(name)) }
      end

      describe '#group' do
        let(:group_name) { 'admins' }
        before { content_builder.group { name group_name } }
        its(:groups) { should include(Group.new(group_name, [])) }
      end

      describe '#build' do
        let(:group_name) { 'administrators'}
        let(:first_name) { 'John' }
        let(:second_name) { 'Doe' }
        let(:username) { [first_name, second_name].join('_') }
        let(:email) { "#{username}@example.com" }
        let(:password) { '123qwe' }
        let(:password_hash) { "{SHA}#{Digest::SHA1.base64digest(password)}" }
        let(:config) { Pathname.getwd.join('spec','assets','expect_config', 'ldif', 'content_builder_config', 'build.txt').read }
        let(:result_string) { config % { first_name: first_name, second_name: second_name, group_name: group_name, username: username, password_hash: password_hash, email: email } }
        before do
          content_builder.person do
            first_name 'John'
            second_name 'Doe'
            password '123qwe'
          end

          content_builder.group do
            name group_name
            member "#{username}"
          end
        end
        its(:build) { should == result_string }
      end

    end
  end
end