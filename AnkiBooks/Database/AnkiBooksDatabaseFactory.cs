using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.VisualBasic;

namespace AnkiBooks;

public class AnkiBooksDatabaseFactory : IDesignTimeDbContextFactory<AnkiBooksDatabase>
{
    public AnkiBooksDatabase CreateDbContext(string[] args)
    {
      var optionsBuilder = new DbContextOptionsBuilder<AnkiBooksDatabase>();
      optionsBuilder.UseNpgsql("Host=localhost;Database=anki;Username=postgres;Password=password");
      return new AnkiBooksDatabase(optionsBuilder.Options);
    }
}