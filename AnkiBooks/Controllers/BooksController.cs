using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("[controller]")]
public class BooksController : ApplicationController
{
    BooksController(AnkiBooksDatabase dbContext,
                      ILogger<BooksController> logger) : base(dbContext, logger)
    {
    }

    [HttpGet]
    public IEnumerable<Book> Index()
    {
        return _dbContext.Books.Where(b => b.ParentBookId == null).ToList();
    }
}
