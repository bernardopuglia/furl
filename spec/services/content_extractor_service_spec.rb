require 'rails_helper'

describe ContentExtractorService, type: :service do
  
  describe '#call' do
    subject { described_class.new.call(base_url, desired_content) }
    
    context 'when document has valid content' do
      let(:html_content) { file_fixture('file.html').read }
      let(:base_url) { 'https://somesite.com' }
      let(:desired_content) { {'img': 'src', 'a': 'href'} }
      
      let(:expected_content) {
        {
        'a': ['https://www.a.com', 'http://www.b.com'],
        'img': ['https://www.a.com/a.jpg', 'http://www.b.com/b.jpg']
        }
      }

      before do
        WebMock.stub_request(:get, base_url).to_return(body: html_content, status: 200)
      end

      it 'extracts the required content' do
        expect(subject).to(eq(expected_content))
      end
    end
  end
end