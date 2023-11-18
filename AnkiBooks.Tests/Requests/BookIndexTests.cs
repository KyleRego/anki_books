using Microsoft.AspNetCore.Builder;
using AnkiBooks;
using System.Net;
using Microsoft.AspNetCore.Mvc.Testing;

namespace AnkiBooks.Tests.Requests;

public class BookIndexTests : AbstractRequestsTestsBase
{

    public BookIndexTests() : base()
    {
        _app.Run();
    }

    [Fact]
    public async Task BookIndexReturns200OKAsync()
    {
        string endpoint = "/book";

        HttpRequestMessage request = new(HttpMethod.Get, endpoint);

        HttpResponseMessage response = await _httpClient.GetAsync(endpoint);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }
}
