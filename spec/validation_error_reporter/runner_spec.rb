require "spec_helper"

module ValidationErrorReporter
  describe Runner do

    before do
      company = Company.new
      company.save(validate: false)
    end

    describe "#run(options)" do
      it "fetches the models and processes the errors" do
        expect(Rails).to receive_message_chain(:application, :eager_load!)
        expect(Entity).to receive(:models_for).with(nil).and_return([Company])
        configuration = Configuration.new
        expect(Configuration).to receive(:new).and_return(configuration)
        reporter = Reporter.new(configuration)
        expect(Reporter).to receive(:new).and_return(reporter)
        expect(reporter).to receive(:report).exactly(1).times
        expect(reporter).to receive(:finalize).exactly(1).times

        subject.run
      end
    end

  end
end
