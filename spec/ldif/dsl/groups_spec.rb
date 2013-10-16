require 'ldif/dsl/group'
require 'pathname'

module LDIF
  module DSL
    describe Group do
      let(:builder) { Group::Builder.new }
      let(:group) { builder.build }
      let(:name) { 'Name' }
      let(:username) { 'email@example.com' }

      subject { group }

      describe 'fields' do
        it { should respond_to(:name) }
        it { should respond_to(:members) }
      end

      describe Group::Builder do
        describe '#name' do
          before { builder.name name }
          it "builds group with name = #{name}" do
            expect(group.name).to eq name
          end
        end
        describe '#member' do
          it 'builds group with empty members' do
            expect(group.members).to be_empty
          end
          context 'group with one member' do
            let(:username) { 'John_Doe' }
            before { builder.member username }
            it "builds group with username" do
              expect(group.members).to include username
            end
          end
        end
      end

      describe '#to_s' do
        let(:config) { Pathname.getwd.join('spec','assets','expect_config','ldif','groups_config', file_name).read }
        let(:result_string) { config }
        let(:email) { 'email@example.com' }

        context 'without members' do
          let(:file_name) { 'without_members.txt' }
          let(:result_string) { config % {name: name} }
          before { builder.name(name) }
          its(:to_s) { should == result_string }
        end

        context 'with one member' do
          let(:file_name) { 'with_one_member.txt' }
          let(:result_string) { config % {name: name, email: email} }
          before do
            builder.name(name)
            builder.member(username)
          end
          its(:to_s) { should == result_string }
        end
      end

    end
  end
end