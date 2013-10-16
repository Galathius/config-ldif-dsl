require 'ldif/dsl/person'
require 'pathname'

module LDIF
  module DSL
    describe Person do
      let(:builder) { Person::Builder.new }
      let(:person) { builder.build }
      let(:first_name) { 'Name' }
      let(:second_name) { 'Second_Name' }
      let(:username) { [first_name, second_name].join('_') }
      let(:mail) { "#{username}@example.com" }
      let(:password) { 'password' }
      let(:password_hash) { "{SHA}#{Digest::SHA1.base64digest(password)}" }

      subject { person }

      describe 'fields' do
        it { should respond_to(:first_name) }
        it { should respond_to(:second_name) }
        it { should respond_to(:password) }
      end

      describe Person::Builder do
        shared_examples 'build person with field' do |field_name|
          before { builder.send(field_name, field_name) }
          it "#{field_name}" do
            expect(person.send(field_name)).to eq field_name
          end
        end

        it_behaves_like 'build person with field', :first_name
        it_behaves_like 'build person with field', :second_name

        describe '#password' do
          before { builder.password password }
          it "builds person with password" do
            expect(person.password).to eq password_hash
          end
        end
      end

      describe 'private methods' do
        shared_examples 'private method' do |method_name|
          before do
            builder.first_name first_name
            builder.second_name second_name
          end
          its(method_name) { should == send(method_name) }
        end

        it_behaves_like 'private method', :mail
        it_behaves_like 'private method', :username
      end

      describe '#to_s' do
        let(:config) { Pathname.getwd.join('spec','assets','expect_config', 'ldif','people_config', 'to_s.txt').read }
        let(:result_string) { config % { username: username, second_name: second_name, first_name: first_name, mail: mail, password: password } }
        its(:to_s) { Person.new(first_name, second_name, password).to_s.should == result_string }
      end
    end
  end
end