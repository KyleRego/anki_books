namespace AnkiBooks.Models;

public class Book : Model
{
    string? Title { get; set; }

    Guid ParentBookId { get; set; }

    bool Public { get; set; } = false;
}