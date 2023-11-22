using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;
using Microsoft.AspNetCore.Cors;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("api/[controller]")]
public class BooksController : ApplicationController
{
    public BooksController(AnkiBooksDatabase dbContext,
                      ILogger<BooksController> logger) : base(dbContext, logger)
    {
    }

    [HttpGet]
    public IEnumerable<Book> Index(ILogger<BooksController> logger)
    {
        logger.LogInformation("Hello world from BooksController");
        return _dbContext.Books.Where(b => b.ParentBookId == null).ToList();
    }
}
