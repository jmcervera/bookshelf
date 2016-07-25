require_relative '../../../../apps/web/views/books/new'

class NewBookParams < Hanami::Action::Params
  params do
    required(:book).schema do
      required(:title).filled(:str?)
      required(:author).filled(:str?)
    end
  end
end

RSpec.describe Web::Views::Books::New do
  let(:params)    { NewBookParams.new(book: {}) }
  let(:exposures) { Hash[params: params] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays list of errors when params contains errors' do
    params.valid? # trigger validations

    expect(rendered).to match('There was a problem with your submission')
    expect(rendered).to match('Title is missing')
    expect(rendered).to match('Author is missing')
  end

end

