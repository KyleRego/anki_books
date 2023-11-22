using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;
using Microsoft.AspNetCore.Cors;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("[controller]")]
public class ArticleController : ApplicationController
{
    public ArticleController(AnkiBooksDatabase dbContext,
                      ILogger<ArticleController> logger) : base(dbContext, logger)
    {
    }

    [EnableCors("_myAllowSpecificOrigins")]
    [HttpGet]
    public IEnumerable<Article> Index(ILogger<ArticleController> logger)
    {
        logger.LogInformation("Hello world from ArticlesController");
        return _dbContext.Articles.ToList();
    }
}
