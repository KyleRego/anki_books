using System;
using System.Collections.Generic;

namespace AnkiBooks.Models;

public partial class Article
{
    public Guid Id { get; set; }

    public string Title { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public bool System { get; set; }

    public Guid BookId { get; set; }

    public int OrdinalPosition { get; set; }

    public bool? Reading { get; set; }

    public bool Writing { get; set; }

    public bool Complete { get; set; }

    public virtual ICollection<BasicNote> BasicNotes { get; set; } = new List<BasicNote>();

    public virtual Book Book { get; set; } = null!;

    public virtual ICollection<ClozeNote> ClozeNotes { get; set; } = new List<ClozeNote>();
}
