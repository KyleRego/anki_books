using AnkiBooks.Models;

namespace AnkiBooks;

public class AnkiBooksDatabase : DbContext
{
    public AnkiBooksDatabase(DbContextOptions<AnkiBooksDatabase> options) : base(options) { }

    DbSet<BasicNote> BasicNotes { get; set; }
}