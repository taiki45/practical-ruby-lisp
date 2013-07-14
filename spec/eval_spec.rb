require 'spec_helper'

describe RubyLisp do
  describe ".eval" do
    context "given [:+, 2, 3]" do
      let(:exp) { [:+, 2, 3] }
      subject { RubyLisp._eval(exp, RubyLisp.env) }

      it { should eq 5 }
    end
  end
end
