using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("[controller]")]
public class BookController : ControllerBase
{
    private readonly AnkiBooksDatabase _dbContext;

    private readonly ILogger<BookController> _logger;

    public BookController(AnkiBooksDatabase dbContext, ILogger<BookController> logger)
    {
        _dbContext = dbContext;
        _logger = logger;
    }

    [HttpGet]
    public IEnumerable<Book> Get()
    {
        return _dbContext.Books.Where(b => b.ParentBookId == null).ToList();
    }
}
