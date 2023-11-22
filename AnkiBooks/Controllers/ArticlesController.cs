using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;
using Microsoft.AspNetCore.Cors;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ArticlesController : ApplicationController
{
    public ArticlesController(AnkiBooksDatabase dbContext,
                      ILogger<ArticlesController> logger) : base(dbContext, logger)
    {
    }

    [HttpGet]
    public IEnumerable<Article> Index(ILogger<ArticlesController> logger)
    {
        logger.LogInformation("Hello world from ArticlesController");
        return _dbContext.Articles.ToList();
    }
}
