require 'spec_helper'

describe ReportDecorator do
  subject(:report) { Report.make.decorate }

  describe '#name' do
    context 'when persisted' do
      it 'uses created_at' do
        report.stub(:new_record?).and_return(false)
        report.should_receive(:created_at).and_return(Date.new(2014, 5, 8))

        expect(report.name).to eql 'Report May 8th 2014 - 00:00'
      end
    end

    context 'when new record' do
      it 'uses todays date' do
        Date.should_receive(:today).and_return(Date.new(2014, 01, 01))
        expect(report.name).to eql 'Report January 1st 2014 - 00:00'
      end
    end
  end
end