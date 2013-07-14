require 'pry'
require File.expand_path('../eval', __FILE__)

describe RubyScheme do
  describe ".eval" do
    context "given [:+, 2, 3]" do
      let(:exp) { [:+, 2, 3] }
      subject { RubyScheme._eval(exp, RubyScheme.env) }

      it { should eq 5 }
    end
  end
end
