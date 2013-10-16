require 'pathname'
require 'ldif/dsl'

describe '.ldif' do
  let(:config) { Pathname.getwd.join('spec','assets','expect_config', 'ldif','dsl_config', file_name).read }
  let(:file_name) { 'name.txt' }
  let(:result_string) { config }
  let(:dsl_block) { nil }
  subject { LDIF::DSL.ldif(&dsl_block) }

  context 'when empty block' do
    let(:file_name) { 'when_empty_block.txt' }
    let(:dsl_block) { proc {} }

    it { should == result_string }
  end

  context 'when no empty block' do
    let(:file_name) { 'when_no_empty_block.txt' }
    let(:block) do
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
    end

    it { (LDIF::DSL.ldif(&block)).should == result_string }
  end

end
