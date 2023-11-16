using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Npgsql;

using AnkiBooks;
using AnkiBooks.Controllers;

namespace AnkiBooks.XTests;

public class BookTests : IClassFixture<DatabaseFixture>
{
    private readonly AnkiBooksDatabase _context;

    public BookTests(DatabaseFixture fixture)
    {
        _context = fixture.Context;
    }

    // public BookTests(AnkiBooksDatabase context) : IClassFixture<DatabaseFixture>
    // {
    //     string connectionString = "Host=localhost;Database=anki_books_test;Username=postgres;Password=password;";
    //     _connection = new NpgsqlConnection(connectionString);
    //     _connection.Open();
    //     _transaction = _connection.BeginTransaction();

    //     DbContextOptions<AnkiBooksDatabase> options = new DbContextOptionsBuilder<AnkiBooksDatabase>()
    //         .UseNpgsql(connectionString)
    //         .Options;

    //     _context = new AnkiBooksDatabase(options);
    //     _context.Database.EnsureCreated();
    // }

    [Fact]
    public void Test1()
    {
        Console.WriteLine("hello world");
    }

    private void Dispose()
    {
        _context.Dispose();
    }
}