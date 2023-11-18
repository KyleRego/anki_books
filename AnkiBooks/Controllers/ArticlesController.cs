using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("[controller]")]
public class ArticlesController : ApplicationController
{
    ArticlesController(AnkiBooksDatabase dbContext,
                      ILogger<ArticlesController> logger) : base(dbContext, logger)
    {
    }

    [HttpGet]
    public IEnumerable<Article> Index()
    {
        return _dbContext.Articles.ToList();
    }
}
