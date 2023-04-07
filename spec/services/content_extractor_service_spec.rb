require 'rails_helper'

describe ContentExtractorService, type: :service do
  
  describe '#call' do
    subject { described_class.new.call(base_url, desired_content) }
    
    context 'when document has all the desired content' do
      let(:html_content) { file_fixture('page_full_content.html').read }
      let(:base_url) { 'https://somesite.com/' }
      let(:desired_content) { {'img': 'src', 'a': 'href'} }
      
      let(:expected_content) {
        {
        'a': ['https://www.a.com', 'https://www.b.com'],
        'img': ['https://www.b.com/b.jpg', 'https://www.a.com/a.jpg']
        }
      }

      before do
        WebMock.stub_request(:get, base_url).to_return(body: html_content, status: 200)
      end

      it 'extracts the required content' do
        expect(subject).to(match(hash_including(expected_content)))
      end
    end

    context 'when part of the desired content does not exist' do
      let(:html_content) { file_fixture('page_no_img.html').read }
      let(:base_url) { 'https://somesite.com/' }
      let(:desired_content) { {'img': 'src', 'a': 'href'} }
      
      let(:expected_content) {
        {
        'a': ['https://www.a.com', 'https://www.b.com'],
        'img': []
        }
      }

      before do
        WebMock.stub_request(:get, base_url).to_return(body: html_content, status: 200)
      end

      it 'extracts the required content' do
        expect(subject).to(match(hash_including(expected_content)))
      end
    end

    context 'when URL is invalid' do
      let(:base_url) { 'not a valid url' }
      let(:desired_content) { {'img': 'src', 'a': 'href'} }

      it 'raises an error for the invalid url' do

        expect { subject }.to(raise_error('URL is invalid: not a valid url'))
      end
    end
  end
end