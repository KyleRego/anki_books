using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class Book
{
    public Guid Id { get; set; }

    public string Title { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public Guid? ParentBookId { get; set; }

    public bool Public { get; set; }

    public virtual ICollection<Article> Articles { get; set; } = new List<Article>();

    public virtual ICollection<BooksUser> BooksUsers { get; set; } = new List<BooksUser>();

    public virtual ICollection<Book> InverseParentBook { get; set; } = new List<Book>();

    public virtual Book? ParentBook { get; set; }
}
