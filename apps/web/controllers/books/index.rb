module Web::Controllers::Books
  class Index
    include Web::Action

    # Deliberately not exposing books
    # specs for Web Webb::Books
    # expose :books

    def call(params)
      @books = BookRepository.all
    end
  end
end
