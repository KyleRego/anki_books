import React, { Component } from 'react';

export class FetchData extends Component {
  static displayName = FetchData.name;

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
      : FetchData.renderBooksList(this.state.books);

    return (
      <div>
        <h1 id="tableLabel">Books</h1>
        <p>This component demonstrates fetching data from the server.</p>
        {contents}
      </div>
    );
  }

  async populateBooksData() {
    const response = await fetch("book");
    const data = await response.json();
    console.log(data);
    this.setState({ books: data, loading: false });
  }
}
