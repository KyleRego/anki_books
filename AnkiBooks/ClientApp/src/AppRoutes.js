import { ArticlesIndex } from "./components/ArticlesIndex";
import { Counter } from "./components/Counter";
import { BooksIndex } from "./components/BooksIndex";
import { Home } from "./components/Home";

const AppRoutes = [
  {
    index: true,
    element: <Home />
  },
  {
    path: '/counter',
    element: <Counter />
  },
  {
    path: '/books',
    element: <BooksIndex />
  },
  {
    path: '/articles',
    element: <ArticlesIndex />
  }
];

export default AppRoutes;
