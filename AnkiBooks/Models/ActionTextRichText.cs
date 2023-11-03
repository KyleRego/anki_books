using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class ActionTextRichText
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Body { get; set; }

    public string RecordType { get; set; } = null!;

    public Guid RecordId { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }
}
