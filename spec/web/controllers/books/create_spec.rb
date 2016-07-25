require_relative '../../../../apps/web/controllers/books/create'

RSpec.describe Web::Controllers::Books::Create do
  let(:action) { described_class.new }

  before do
    BookRepository.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm'}] }

    it 'creates a new book' do
      action.call(params)
      expect(action.book.id).not_to be nil
      # NOTE: I had to change the next line after including validation
      # expect(action.book.title).to eq params[:book][:title]
      expect(action.book.title).to eq params[:book]['title']
    end

    it 'redirects the user to the books listings' do
      response = action.call(params)
      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/books'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 're-renders the books#new view' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'sets errors attribute accordingly' do
      response = action.call(params)
      expect(response[0]).to eq 422
      # NOTE: In the tutorial it's said to expect string 'must be filled'
      expect(action.params.errors[:book][:title]).to eq ['is missing']
      expect(action.params.errors[:book][:author]).to eq ['is missing']

    end
  end
end
