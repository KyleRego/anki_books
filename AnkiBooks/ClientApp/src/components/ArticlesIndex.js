import React, { Component } from "react";
import client from "../client";

export class ArticlesIndex extends Component {
  static displayName = ArticlesIndex.name;

  constructor(props) {
    super(props);
    this.state = { articles: [], loading: true };
  }

  componentDidMount() {
    this.populateArticlesData();
  }

  static renderArticlesList(articles) {
    return (
      <div>
          {articles.map(article =>
            <div key={article.id}>
              <span>{article.title}</span>
            </div>
          )}
      </div>
    );
  }

  render() {
    let contents = this.state.loading
      ? <p><em>Loading...</em></p>
      : ArticlesIndex.renderArticlesList(this.state.articles);

    return (
      <div>
        <h1 id="tableLabel">Articles</h1>
        <p>This component demonstrates fetching data from the server.</p>
        {contents}
      </div>
    );
  }

  async populateArticlesData() {
    try {
      const data = await client.get("articles");
      this.setState({ articles: data, loading: false });
    } catch(error) {
      console.log("Something went wrong:");
      console.log(error);
    }
  }
}
