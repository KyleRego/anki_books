using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;
using Microsoft.AspNetCore.Cors;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("[controller]")]
public class BookController : ApplicationController
{
    public BookController(AnkiBooksDatabase dbContext,
                      ILogger<BookController> logger) : base(dbContext, logger)
    {
    }

    [EnableCors("_myAllowSpecificOrigins")]
    [HttpGet]
    public IEnumerable<Book> Index(ILogger<BookController> logger)
    {
        logger.LogInformation("Hello world from BooksController");
        return _dbContext.Books.Where(b => b.ParentBookId == null).ToList();
    }
}
