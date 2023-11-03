namespace AnkiBooks.Models;

public class BasicNote : Model
{
    string Front { get; set; } = "";

    string Back { get; set; } = "";

    Guid ArticleId { get; set; }

    int OrdinalPosition { get; set; }

    string? AnkiGuid { get; set; }
}