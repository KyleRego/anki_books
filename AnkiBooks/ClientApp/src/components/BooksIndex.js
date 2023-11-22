import React, { Component } from 'react';

export class BooksIndex extends Component {
  static displayName = BooksIndex.name;

  constructor(props) {
    super(props);
    this.state = { books: [], loading: true };
  }

  componentDidMount() {
    this.populateBooksData();
  }

  static renderBooksList(books) {
    return (
      <div>
        {books.map(book =>
          <div key={book.id}>
            <span>{book.title}</span>
          </div>
        )}
      </div>
    );
  }

  render() {
    let contents = this.state.loading
      ? <p><em>Loading...</em></p>
      : BooksIndex.renderBooksList(this.state.books);

    return (
      <div>
        <h1 id="tableLabel">Books</h1>
        <p>This component demonstrates fetching data from the server.</p>
        {contents}
      </div>
    );
  }

  async populateBooksData() {
    const endpoint = "https://localhost:5234/api/books";
    console.log(endpoint);
    const response = await fetch(endpoint);
    console.log(response);
    const data = await response.json();
    this.setState({ books: data, loading: false });
  }
}
