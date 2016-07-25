module Web::Controllers::Books
  class Create
    include Web::Action

    expose :book

    params do
      required(:book).schema do
        required(:title).filled(:str?)
        required(:author).filled(:str?)
      end
    end

    def call(params)
      if params.valid?
        @book = BookRepository.create(Book.new(params[:book]))
        redirect_to '/books'
      else
        self.status = 422
      end
    end
  end
end
