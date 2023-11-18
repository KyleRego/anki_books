using System.Net;
using Microsoft.AspNetCore.Builder;
using AnkiBooks;
using Microsoft.AspNetCore.Mvc.Testing;

namespace AnkiBooks.Tests.Requests;

public abstract class AbstractRequestsTestsBase
{
    protected HttpClient _httpClient;
    protected WebApplication _app;

    protected AbstractRequestsTestsBase()
    {
        _httpClient = new HttpClient
        {
            BaseAddress = new Uri("http://localhost:52345")
        };

        _app = AnkiBooksApplication.Application(AnkiBooksApplication.ApplicationBuilder());
    }
}
