using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class BooksUser
{
    public Guid Id { get; set; }

    public Guid UserId { get; set; }

    public Guid BookId { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public virtual Book Book { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
