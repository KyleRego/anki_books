using AnkiBooks;
using Microsoft.EntityFrameworkCore;

namespace AnkiBooks.XTests;

public class DatabaseFixture : IDisposable
{
    public AnkiBooksDatabase Context { get; private set; }

    public DatabaseFixture()
    {
        // Set up your context for the entire test class
        string connectionString = "Host=localhost;Database=anki_books_test;Username=postgres;Password=password;";
        DbContextOptions<AnkiBooksDatabase> options = new DbContextOptionsBuilder<AnkiBooksDatabase>()
            .UseNpgsql(connectionString)
            .Options;
        Context = new AnkiBooksDatabase(options);
        Context.Database.EnsureCreated();
    }

    public void Dispose()
    {
        // Clean up resources after all tests in the class
        Context.Database.EnsureDeleted();
        Context.Dispose();
        GC.SuppressFinalize(this);
    }
}