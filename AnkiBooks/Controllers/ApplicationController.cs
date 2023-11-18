using Microsoft.AspNetCore.Mvc;
using AnkiBooks.Database;

namespace AnkiBooks.Controllers;

public abstract class ApplicationController : ControllerBase
{
    protected readonly AnkiBooksDatabase _dbContext;

    protected readonly ILogger<ApplicationController> _logger;

    public ApplicationController(AnkiBooksDatabase dbContext, ILogger<ApplicationController> logger)
    {
        _dbContext = dbContext;
        _logger = logger;
    }
}