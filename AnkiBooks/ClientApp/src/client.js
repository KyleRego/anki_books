const BASE_API_URL = "https://localhost:5234";

class AnkiBooksClient {
  constructor() {
    this.base_url = BASE_API_URL + "/api";
  }

  async get(path) {
    try {
      const endpoint = `${this.base_url}/${path}`
      const response = await fetch(endpoint);
      const data = response.json();
      return data;
    } catch (error) {
      console.log("Something went wrong make a GET request:")
      console.log(error);
    }
  }
}

const client = new AnkiBooksClient();

export default client;