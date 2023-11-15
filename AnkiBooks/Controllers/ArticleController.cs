using AnkiBooks.Models;
using Microsoft.AspNetCore.Mvc;

namespace AnkiBooks.Controllers;

[ApiController]
[Route("[controller]")]
public class ArticleController : ControllerBase
{
    private readonly AnkiBooksDatabase _dbContext;

    private readonly ILogger<ArticleController> _logger;

    public ArticleController(AnkiBooksDatabase dbContext, ILogger<ArticleController> logger)
    {
        _dbContext = dbContext;
        _logger = logger;
    }

    [HttpGet]
    public IEnumerable<Article> Index()
    {
        return _dbContext.Articles.ToList();
    }
}
