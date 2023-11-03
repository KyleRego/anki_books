using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class User
{
    public Guid Id { get; set; }

    public string? Email { get; set; }

    public string? Username { get; set; }

    public string? PasswordDigest { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public virtual ICollection<BooksUser> BooksUsers { get; set; } = new List<BooksUser>();

    public virtual ICollection<Concept> Concepts { get; set; } = new List<Concept>();
}
