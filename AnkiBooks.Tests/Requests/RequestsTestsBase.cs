using System.Net;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc.Testing;
using AnkiBooks;

namespace AnkiBooks.Tests.Requests;

public abstract class RequestsTestsBase
{
    protected HttpClient _httpClient;
    protected WebApplication _app;

    protected RequestsTestsBase()
    {
        _httpClient = new HttpClient
        {
            BaseAddress = new Uri("http://localhost:52345")
        };

        _app = AnkiBooksApplication.Application(AnkiBooksApplication.ApplicationBuilder());
    }
}
